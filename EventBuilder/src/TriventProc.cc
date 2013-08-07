/**
 * Yacine HADDAD
 * LLR Ecole polytechnique
 * avril 2012
 * Trivent v0.3
 */

#include <TriventProc.hh>
#include <EVENT/LCCollection.h>
#include <IMPL/LCCollectionVec.h>
#include <IMPL/LCEventImpl.h>
#include <EVENT/MCParticle.h>
#include <EVENT/CalorimeterHit.h>
#include <IMPL/CalorimeterHitImpl.h>
#include <EVENT/RawCalorimeterHit.h>
#include <values.h>
#include <string>
#include <iostream>
#include <cmath>
#include <TMath.h>
#include <EVENT/LCFloatVec.h>
#include <EVENT/LCParameters.h>
#include <stdexcept>  
#include <TFile.h> 
#include <TTree.h>
#include <Rtypes.h> 
#include <sstream>		
#include <UTIL/CellIDEncoder.h>
#include "Mapping.h"
#include "TObject.h"
#include "TRefArray.h"
#include "TRef.h"
#include <fstream>
#include <algorithm>
#include "marlin/VerbosityLevels.h"
#include "marlin/tinyxml.h"

#define DEBUG false
 
TriventProc a_TriventProc_instance;
bool TriventProc::MinOnLayerCut(int nch_cut = 7 ){
  // select the event which fired more than zcut = 10(in default) layer 
  //-------------------------------
  TH1F *_hZhit = new TH1F("_hZhit","hit in z",50,0,50);
#if DEBUG
  std::cout<<"vector lenght == "<<zcut.size() <<std::endl;
#endif  
  for(uint ihit=0; ihit< zcut.size() ; ihit++){
    _hZhit->Fill(zcut[ihit]);
  }
  //-------------------------------
  int NZ = 0;
  for(int k=0; k<50;k++){
    int N = _hZhit->GetBinContent(k);
    if( N > 0 ) NZ++;
  }
  _hZhit->Delete();
#if DEBUG
  std::cout << "number of the plan == " << NZ << std::endl;
#endif
  //-------------------------------
  if(NZ >= nch_cut){
    return true;
  }else{
    return false;
  }
  zcut.clear();
}

//=========================================================
TriventProc::TriventProc()
  : Processor("TriventProc"),
    _output(0),
    _outputTree(0)//,
    //_hitArray(0)
{
  
  cout<< "Trivent ... begin " << endl;
  _rejectedNum = 0;
  
  // collection 
  std::vector<std::string> hcalCollections;    
  hcalCollections.push_back(std::string("DHCALRawHits"));
  registerInputCollections( LCIO::RAWCALORIMETERHIT , 
			    "HCALCollections"       ,  
			    "HCAL Collection Names" ,  
			    _hcalCollections        , 
			    hcalCollections         ); 
  
  // Option of output file with clean events
  _outFileName="LCIO_clean_run.slcio";
  registerProcessorParameter("LCIOOutputFile" , 
			     "LCIO file" ,
			     _outFileName ,
			     _outFileName);
  // Energy
  _beamEnergy = 10;
  registerProcessorParameter("beamEnergy" ,
                             "The beam ",
                             _beamEnergy ,
                             _beamEnergy);
  // Option of output file with noise
  _noiseFileName="noise_run.slcio";
  registerProcessorParameter("NOISEutputFile" , 
			     "NOISE file" ,
			     _noiseFileName ,
			     _noiseFileName);
  
  // layer cut 
  _LayerCut = 10;
  registerProcessorParameter("LayerCut" ,
                             "cut in number of layer 10 in default",
                             _LayerCut ,
                             _LayerCut);


  // noise cut
  _noiseCut = 10;
  registerProcessorParameter("noiseCut" ,
                             "noise cut in time spectrum 10 in default",
                             _noiseCut ,
                             _noiseCut);

  // time windows
  _timeWin = 2;
  registerProcessorParameter("timeWin" ,
                             "time window = 2 in default",
                             _timeWin ,
                             _timeWin);
  //maping on XML file
  _geomXML = "setup_geometry.xml";
  registerProcessorParameter("setup_geometry" ,
                             "Dif geometry and position on the detector XML",
                             _geomXML,
                             _geomXML);
  
  //maping on txt file
  _mappingfile = "mapping_ps.txt";
  registerProcessorParameter("DIFMapping" ,
                             "dif's mapping file ",
                             _mappingfile,
                             _mappingfile);
  //inter layer
  _layer_gap = 9.;
  registerProcessorParameter("layerGap" ,
                             "Layers Gap in (cm)",
                             _layer_gap,
                             _layer_gap);
  // electronic noise cut
  _elec_noise_cut = 5000;
  registerProcessorParameter("electronic_noise_cut" ,
                             "number of hit max on time stamp",
                             _elec_noise_cut,
                             _elec_noise_cut);

  // electronic noise cut
  _time2prev_event_cut = 0;
  registerProcessorParameter("_time2prev_event_cut" ,
                             "cut on time to previous event (x 200 ns)",
                             _time2prev_event_cut,
                             _time2prev_event_cut);
  
  //log root file
  _treeName = "TEST";
  registerProcessorParameter("TreeName_logroot" ,
                             "Logroot tree name",
                             _treeName,
			     _treeName);
  // histogram control tree 
  _logrootName = "logroot.root";
  registerProcessorParameter("logroot_Name" ,
                             "Logroot name",
                             _logrootName,
			     _logrootName);
  
  GAIN_CORRECTION_MODE = false;
  registerProcessorParameter("GAIN_CORRECTION_MODE",
                             "GAIN_CORRECTION_MODE",
                             GAIN_CORRECTION_MODE,
			     GAIN_CORRECTION_MODE);
  
} 

void TriventProc::XMLReader(std::string xmlfile){
  TiXmlDocument doc(xmlfile.c_str());
  bool load_key = doc.LoadFile();  
  if(load_key){
    std::cout << green << "File : " << xmlfile.c_str() << normal <<std::endl;
    // tout ici 
    TiXmlHandle hDoc(&doc);
    TiXmlElement* pElem;
    TiXmlHandle hRoot(0);
    // name block
    {
      pElem=hDoc.FirstChildElement().Element();
      // should always have a valid root but handle gracefully if it does
      if (!pElem) std::cout << red << "error elem" << normal << std::endl;
      std::cout << green << pElem->Value() << normal << std::endl;
      
      // save this for later
      hRoot=TiXmlHandle(pElem);
    }
    // parameters block
    {
      m_parameters.clear();
      pElem=hRoot.FirstChild("parameter").Element();
      std::string key = pElem->Attribute("name");
      std::cout << green << key.c_str() << normal << std::endl; 
#ifdef DEBUG
      {
      	std::cout << green
      		  <<"parameter : " 
      		  << pElem->Attribute("name") 
      		  << normal 
      		  << std::endl;
      }
#endif
      std::vector<std::string> lines;
      {
	stringbuf *pbuf;
	std::string value = pElem->GetText() ;
	std::vector<std::string> lines;
	istringstream iss(value);
	copy(istream_iterator<string>(iss),
             istream_iterator<string>(),
             back_inserter<vector<string> >(lines));
	for(int iline = 0; iline < lines.size(); iline++){
	  std::string line = lines.at(iline);
	  std::cout << red << line << normal << std::endl;
	  
	  stringstream ss( line.c_str() );
	  vector<string> result;
	  
	  LayerID mapp;
	  int Dif_id;
	  while( ss.good() )
	    {
	      string substr;
	      getline( ss, substr, ',' );
	      result.push_back( substr );
	    }
	  istringstream ( result.at(0) ) >> Dif_id;
	  istringstream ( result.at(1) ) >> mapp.K;
	  istringstream ( result.at(2) ) >> mapp.DifX;
	  istringstream ( result.at(3) ) >> mapp.DifY;
	  istringstream ( result.at(4) ) >> mapp.IncX;
	  istringstream ( result.at(5) ) >> mapp.IncY;
	  _mapping[Dif_id] = mapp;
	}
      }
      pElem = pElem->NextSiblingElement();
      // ChamberGeom  Node.
      {
#ifdef DEBUG
	{
	  std::cout << green
		    <<"parameter : " 
		    << pElem->Attribute("name") 
		    << normal 
		    << std::endl;
	}
#endif
	std::vector<std::string> lines;
	{
	  stringbuf *pbuf;
	  std::string value = pElem->GetText() ;
	  std::vector<std::string> lines;
	  istringstream iss(value);
	  copy(istream_iterator<string>(iss),
	       istream_iterator<string>(),
	       back_inserter<vector<string> >(lines));
	  for(int iline = 0; iline < lines.size(); iline++){
	    std::string line = lines.at(iline);
	    std::cout << red << line << normal << std::endl;
	    
	    stringstream ss( line.c_str() );
	    vector<string> result;
	    
	    double position;
	    int Dif_id;
	    while( ss.good() )
	      {
		string substr;
		getline( ss, substr, ',' );
		result.push_back( substr );
	      }
	    istringstream ( result.at(0) ) >> Dif_id;
	    istringstream ( result.at(3) ) >> position;
	    
	    _chamber_pos[Dif_id] = position;
	  }
	}
      }
    }
  }else{
    std::cout << red << "Failed to load file : " << xmlfile.c_str() << normal <<std::endl;
  }
}

void TriventProc::readDifGeomFile(std::string geomfile){
  
  cout << "read the mapping file .."<< endl;
  
  LayerID contenu;
  ifstream file(geomfile.c_str(), ios::in);
  if(file){ 
    while(!file.eof()){
      int Dif_id;
      char co;
      file >> Dif_id >> co 
	   >> contenu.K >> co 
	   >> contenu.DifX >> co 
	   >> contenu.DifY >> co  
	   >> contenu.IncX >> co  
	   >> contenu.IncY ;
      _mapping [Dif_id] = contenu;
    }
    file.close();
  }
  else
    cerr << "ERROR ... maping file not correct !" << endl;
}

void TriventProc::printDifGeom(){
  
  for(std::map<int,LayerID>::iterator itt = _mapping.begin();itt!=_mapping.end();itt++)     {
    std::cout << itt->first << "\t" << itt->second.K 
	      <<"\t"<<itt->second.DifX 
	      <<"\t"<<itt->second.DifY
	      <<"\t"<<itt->second.IncX
	      <<"\t"<<itt->second.IncY
	      << std::endl;
  }
}

// ============ decode the cell ids =============
uint TriventProc::getCellDif_id(int cell_id){
  return cell_id & 0xFF;
}
uint TriventProc::getCellAsic_id(int cell_id){
  return (cell_id & 0xFF00)>>8;
}
uint TriventProc::getCellChan_id(int cell_id){
  return (cell_id & 0x3F0000)>>16;
}

uint* TriventProc::getPadIndex(uint dif_id, uint asic_id, uint chan_id){
  _index[0]=_index[1]=_index[2]=0;
  double DifY = -1.,DifZ = -1.;
  DifZ = _mapping.find(dif_id)->second.K;
  DifY = _mapping.find(dif_id)->second.DifY;
  _index[0] = (1+MapILargeHR2[chan_id]+AsicShiftI[asic_id]);
  _index[1] = (32-(MapJLargeHR2[chan_id]+AsicShiftJ[asic_id]))+int(DifY);
  _index[2] = fabs(int(DifZ));
#if DEBUG
  std::cout << " Dif_id == " << dif_id
	    << " Asic_id ==" << asic_id
	    << " Chan_id ==" << chan_id
	    << " I == " << _index[0]
	    << " J == " << _index[1]
	    << " K == " << _index[2]
	    << std::endl;
#endif  
  return _index;
}
//===============================================
void TriventProc::getMaxTime()
{
  _maxtime = 0;
  try{
    for(std::vector<EVENT::RawCalorimeterHit*>::iterator raw_hit=_trigger_raw_hit.begin();raw_hit!= _trigger_raw_hit.end();raw_hit++){
      int time =  int((*raw_hit)->getTimeStamp());
      if(time >= 0) _maxtime = max(_maxtime, time);
    }
  }catch (std::exception ec){
    std::cout<<"No hits "<<std::endl;
  }
  std::cout << " maxtime before == " << _maxtime << std::endl;
  //return maxtime;
}


uintVec TriventProc::getTimeSpectrum() //__attribute__((optimize(0)))
{
  uintVec time_spectrum(_maxtime+1);
  try{
    for(std::vector<EVENT::RawCalorimeterHit*>::iterator raw_hit=_trigger_raw_hit.begin();raw_hit!= _trigger_raw_hit.end();raw_hit++){  
      int time =  int((*raw_hit)->getTimeStamp());
      if(time >= 0) time_spectrum[time]++;
    }
  }catch (std::exception ec){
    std::cout<<"No hits "<<std::endl;
  }
  return time_spectrum;
}

bool TriventProc::peakOrNot(uintVec time_spectrum ,uint itime ,uint threshold){
  
#if HISTOGRAM_PARSER
  noise_dist->Fill(time_spectrum[itime]);
#endif
  
  if(time_spectrum[itime] >= threshold
     && time_spectrum[itime] >  time_spectrum[itime+1]  
     && time_spectrum[itime] >= time_spectrum[itime+1]){
    return true;
  }else{
    return false;
  }
}

void TriventProc::eventBuilder(LCCollection* col_event,uint time_peak, uint prev_time_peak){
  zcut.clear();
  col_event->setFlag(col_event->getFlag()|( 1 << LCIO::RCHBIT_LONG));
  col_event->setFlag(col_event->getFlag()|( 1 << LCIO::RCHBIT_TIME));
  //std::cout << "test 0" << std::endl;
  CellIDEncoder<CalorimeterHitImpl> cd( "I:8,J:7,K:10,Dif_id:8,Asic_id:6,Chan_id:7" ,col_event) ;
  //std::cout << "test 1" << std::endl;
  try{
    //for (int ihit(0); ihit < col_trigger->getNumberOfElements(); ++ihit) {
      
    //RawCalorimeterHit *rawhit = dynamic_cast<RawCalorimeterHit*>(col_trigger->getElementAt(ihit)) ;
    for(std::vector<EVENT::RawCalorimeterHit*>::iterator rawhit=_trigger_raw_hit.begin();rawhit!= _trigger_raw_hit.end();rawhit++){  
      //if(NULL != rawhit){
      float pos[3];
      int time = (*rawhit)->getTimeStamp();
      if(fabs(time-time_peak) <=_timeWin && 
	 (time > prev_time_peak + _timeWin )){
	  
	int Dif_id  =  getCellDif_id ((*rawhit)->getCellID0());
	int Asic_id =  getCellAsic_id((*rawhit)->getCellID0());
	int Chan_id =  getCellChan_id((*rawhit)->getCellID0());
	  
	uint I = getPadIndex(Dif_id, Asic_id, Chan_id)[0];
	uint J = getPadIndex(Dif_id, Asic_id, Chan_id)[1];
	uint K = getPadIndex(Dif_id, Asic_id, Chan_id)[2];
	pos[0] = I*10.*1.04125;
	pos[1] = J*10.*1.04125;
	pos[2] = _chamber_pos.find(K)->second;
	  
	CalorimeterHitImpl* caloHit = new CalorimeterHitImpl();
	caloHit->setTime(float((*rawhit)->getTimeStamp())); // done !!
	caloHit->setEnergy(float((*rawhit)->getAmplitude()&3));
	// set the cell id 
	cd["I"] = I ;
	cd["J"] = J ;
	cd["K"] = K ;
#if DEBUG
	//      std::cout << " I == " << I
	//		<< " J == " << J
	//		<< " K == " << K
	//		<< std::endl;
#endif
	cd["Dif_id"]  =  Dif_id ;
	cd["Asic_id"] =  Asic_id;
	cd["Chan_id"] =  Chan_id;
	  
	cd.setCellID( caloHit ) ;
	zcut.push_back(K);
	caloHit->setPosition(pos);
	col_event->addElement(caloHit);
      }
      //}else{
      //std::cout << " time peak = "<<time_peak<<" pointer --> : " << rawhit << std::endl;
      //}
    }//loop over the hit     
  }catch(DataNotAvailableException &e){
    streamlog_out(WARNING) << " collection not available" << std::endl;
  }
}

//===============================================
void TriventProc::init() {
  trig_count = 0;
  //========================
  //readDifGeomFile(_mappingfile.c_str());
  
  // ========================
  
  printParameters();
  // new process
  
  char cnormal[8] =  {0x1b,'[','0',';','3','9','m',0};
  char cred[8]     = {0x1b,'[','1',';','3','1','m',0};
  char cgreen[8]   = {0x1b,'[','1',';','3','2','m',0};
  char cyellow[8]  = {0x1b,'[','1',';','3','3','m',0};
  char cblue[8]    = {0x1b,'[','1',';','3','4','m',0};
  char cmagenta[8] = {0x1b,'[','1',';','3','5','m',0};
  char cwhite[8]   = {0x1b,'[','1',';','3','9','m',0};

  normal   = cnormal;
  red      = cred;
  green    = cgreen;
  yellow   = cyellow;
  blue     = cblue;
  magenta  = cmagenta;
  white    = cwhite;

  _lcWriter = LCFactory::getInstance()->createLCWriter() ;
  _lcWriter->setCompressionLevel( 0 ) ;
  _lcWriter->open(_outFileName.c_str(),LCIO::WRITE_NEW) ; 
  
 
  XMLReader(_geomXML.c_str());
  printDifGeom();
  evtnum=0;// event number
}
//==================================================================================
//void TriventProc::setTriggerRawHit() {
  
//}
//==================================================================================
void TriventProc::processRunHeader( LCRunHeader * runHd ) {
  
}

//==================================================================================
void TriventProc::processEvent( LCEvent * evtP ) 
{	
  if (evtP != NULL){
    try{
      
      _eventNr=evtP->getEventNumber();
      for(unsigned int i=0; i< _hcalCollections.size(); i++){//!loop over collection
	try{
	  
	  LCCollection * col = NULL;
	  col = evtP ->getCollection(_hcalCollections[i].c_str());
	  int numElements = col->getNumberOfElements();// hit number 
	  
	  
	  std::cout << yellow << "Trigger name == " << trig_count++ << normal << std::endl;
	  
	  if(col == NULL )  {
	    std::cout<< red << "TRIGGER SKIPED ..."<< normal <<std::endl;
	    break;
	  }
	  
	  if(numElements > _elec_noise_cut)  {
	    std::cout << red << "TRIGGER SKIPED ..."<< normal <<std::endl;
	    break;
	  }
	  
	  // set raw hits 
	  _trigger_raw_hit.clear();
	  for (int ihit(0); ihit < col->getNumberOfElements(); ++ihit) {// loop over the hits
	    RawCalorimeterHit *raw_hit = 
	      dynamic_cast<RawCalorimeterHit*>( col->getElementAt(ihit)) ;
	    if (NULL != raw_hit){
	      _trigger_raw_hit.push_back(raw_hit);
	    }
	  }
	  getMaxTime();
	  uintVec time_spectrum = getTimeSpectrum();
	  
	  //---------------------------------------------------------------
	  //! Find the condidate event
	  uint ibin=0;
	  double bin_c_prev = -2 * _timeWin; //  the previous bin center
	  
	  int time_prev = 0;
	  while(ibin < (_maxtime+1)){ 
	    if(time_spectrum[ibin] >= _noiseCut
	       && time_spectrum[ibin] >  time_spectrum[ibin+1]  
	       && time_spectrum[ibin] >= time_spectrum[ibin+1]){
	      LCEventImpl*  evt = new LCEventImpl() ;     // create the event
	      
	      //---------- set event paramters ------
	      const std::string parname_trigger = "trigger";
	      const std::string parname_energy  = "beamEnergy";
	      evt->parameters().setValue(parname_trigger,evtP->getEventNumber()); 
	      evt->parameters().setValue(parname_energy , _beamEnergy); 
	      evt->setRunNumber( evtP->getRunNumber()) ;
	      //-------------------------------------
	      
	      LCCollectionVec* outcol = new LCCollectionVec(LCIO::CALORIMETERHIT);
	      TriventProc::eventBuilder(outcol,ibin,bin_c_prev);
	      
	      bool TestEvent = MinOnLayerCut(_LayerCut);
	      if(TestEvent &&                                  // the min layer numb cut       
		 abs(int(ibin)-time_prev) > _time2prev_event_cut){ // time2prev event  cut 
#if true		
		std::cout<<green<<" Trivent find event at :==> "<< red << ibin 
			 <<green<<"\t :Nhit: ==> "<< magenta
			 <<outcol->getNumberOfElements() << normal <<std::endl;  
#endif 
		
		
		evt->setEventNumber( evtnum++ ) ;
		evt->addCollection(outcol, "SDHCAL_HIT");
		_lcWriter->writeEvent( evt ) ;
	      }else{
		_rejectedNum++;
		delete outcol;
	      }
	      time_prev = ibin;
	      delete evt; evt=NULL;
	      
	      bin_c_prev = ibin;
	      ibin = ibin+_timeWin;
	    }else{ibin++;}
	  }
	  
	}catch (lcio::DataNotAvailableException zero) {}
      }
    }catch (lcio::DataNotAvailableException err) {}
  }
  
	   
}	
//==============================================================
void TriventProc::end()
{       
  std::cout<< "Trivent Select "<<_rejectedNum <<" Condidate event"<<std::endl;
  std::cout<< "Trivent end"<<std::endl;
  //cc.StoreHistos("test.root");
  _lcWriter->close();
  
  if (_outputTree) {
    TFile *_logroot = _outputTree->GetCurrentFile();
    _logroot->Write();
    delete _logroot;
  }
}
//==============================================================


 
