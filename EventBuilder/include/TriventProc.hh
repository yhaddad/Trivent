#ifndef _TriventProc_hh_
#define _TriventProc_hh_

#define  HISTOGRAM_PARSER true

#include <string>
#include <iostream>
#include <fstream>
#include <marlin/Processor.h>
#include <EVENT/CalorimeterHit.h>
#include <EVENT/RawCalorimeterHit.h>
#include <TNtuple.h>
#include <TObject.h>
#include <TTree.h>
#include <TFile.h>
#include <TH1.h>
#include <TH1F.h>
#include <TH2.h>
#include <TH3.h>
#include "IO/LCWriter.h"
#include <map>
#include <string>
#include <algorithm>
#include "Mapping.h"
using namespace std;
  
class TriventProc  : public marlin::Processor
{
public:
  
  Processor*  newProcessor() { return new TriventProc ; }
  
  TriventProc();
  
  ~TriventProc() {};
  
  void init();
  
  
  void    processEvent( LCEvent * evtP );
  void    processRunHeader( LCRunHeader * runH);// added by me 
  bool    MinOnLayerCut(int nch_cut);
  void    XMLReader(std::string xmlfile);
  void    readDifGeomFile(std::string geomfile);
  void    printDifGeom();
  
  uint    getCellDif_id(int cell_id);
  uint    getCellAsic_id(int cell_id);
  uint    getCellChan_id(int cell_id);

  void    getMaxTime();
  uintVec getTimeSpectrum();
  uint*   getPadIndex(uint dif_id, uint asic_id, uint chan_id);
  void    eventBuilder(LCCollection* col_event,uint time_peak, uint prev_time_peak);
  bool    peakOrNot(uintVec time_spectrum, uint itime ,uint threshold);
  void    end();
  
protected:
  TH1F *noise_dist;
  TH1F *gain_chan;
  TH1F *mean_hit_dif;
  TH1F *time_hit_dif;
  // xml test
  std::map<std::string,std::string> m_parameters;
  
  std::vector<EVENT::RawCalorimeterHit*> _trigger_raw_hit;
  
  bool GAIN_CORRECTION_MODE;
  std::string _outFileName;
  std::string _noiseFileName;
  std::string _treeName;
  std::string _logrootName;
  std::string _colName; 
  std::string _fileName;
  std::string _mappingfile;
  std::string _geomXML;
  std::ostream *_output;
  std::vector<std::string> _hcalCollections;
  int _overwrite;
  TTree *_outputTree;  
  unsigned int _eventNr;  
  Int_t _Nhit; 
  Int_t _elec_noise_cut;
  
  std::map<int, LayerID  > _mapping;
  std::map<int, double  > _chamber_pos;//camber , pos
  
  int _noiseCut;
  int _timeWin;
  int _LayerCut;
  int _time2prev_event_cut;
  double _layer_gap;
  float _beamEnergy;
  int trig_count;
  int _maxtime;
  int evtnum;
  int _rejectedNum;
  uint _index[3];
  uintVec zcut;
  LCWriter* _lcWriter;
  
  std::string normal  ;
  std::string red     ;
  std::string green   ;
  std::string yellow  ;
  std::string blue    ;
  std::string magenta ;
  std::string white   ;

};



#endif


