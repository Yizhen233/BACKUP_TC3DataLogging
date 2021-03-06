///////////////////////////////////////////////////////////////////////////////
// TcAsyncBufferWritingModule.h
#pragma once

#include "TcIoInterfaces.h"
#include "TcAsyncBufferWritingDrvServices.h"
#include "TcAsyncBufferWritingDrvInterfaces.h"

#include "TcRtInterfaces.h"  //getsystime
#include <string>
using namespace std;

#include "TcFileAccessInterfaces.h"
#include "TcFsmFileWriter.h"

#define ASYNCWRITE_BUFFERSIZE 100

///////////////////////////////////////////////////////////////////////////////
// CTcAsyncBufferWritingModule has two buffers (m_Buffer1, m_Buffer2),
// which are filled with current data alternately. The member m_pBufferFill 
// points to the current fill buffer. If a buffer is completely filled, then
// the member m_pBufferWrite is set such that it points to the filled buffer. 
// This data is written to a file using the TcFsmFileWriter. 
class CTcAsyncBufferWritingModule 
	: public ITComObject
	, public ITcADI
///<AutoGeneratedContent id="InheritanceList">
	, public ITcCyclic
///</AutoGeneratedContent>
{
public:
	DECLARE_IUNKNOWN()
	DECLARE_IPERSIST(CID_TcAsyncBufferWritingDrvCTcAsyncBufferWritingModule)
	DECLARE_ITCOMOBJECT_LOCKOP()
	DECLARE_OBJDATAAREA_MAP()
	DECLARE_ITCADI()

	CTcAsyncBufferWritingModule();

	virtual	~CTcAsyncBufferWritingModule();

///<AutoGeneratedContent id="InterfaceMembers">
	// ITcCyclic
	virtual HRESULT TCOMAPI CycleUpdate(ITcTask* ipTask, ITcUnknown* ipCaller, ULONG_PTR context);

///</AutoGeneratedContent>
	struct st_Buffer
	{
		//char Timestamp[32];
		/*char roomtemp[1024];
		char watertemp[1024];
		char signal3[1024];
		char signal4[1024];
		char signal5[1024];
		char signal6[1024];
		char signal7[1024];
		char signal8[1024];
		char signal9[1024];
		char signal10[1024];*/
		double Timestamp;
		double roomtemp;
		double watertemp;
		double signal3;
		double signal4;
		double signal5;
		double signal6;
		double signal7;
		double signal8;
		double signal9;
		double signal10;
	};

protected:
	DECLARE_ITCOMOBJECT_SETSTATE();

	HRESULT AddModuleToCaller();
	VOID RemoveModuleFromCaller();

///<AutoGeneratedContent id="Members">
	TcAsyncBufferWritingModuleParameter m_Parameter;
	TcAsyncBufferWritingModuleInputs m_Inputs;
	TcAsyncBufferWritingModuleOutputs m_Outputs;
	ITcCyclicCallerInfoPtr m_spCyclicCaller;
///</AutoGeneratedContent>

	BOOL FillBuffer
	(
		st_Buffer* pBuffer, 
		UINT nBuffer, 
		UINT& nBufferIndex
		//float* pBuffer, 
	);

	LONGLONG systime;
	double m_counters;
	UINT m_counter;
	char buf[1024] = "\0";
	char bu[1024] = "\0";
	PCCH name;
	st_Buffer m_Buffer1[ASYNCWRITE_BUFFERSIZE];
	st_Buffer m_Buffer2[ASYNCWRITE_BUFFERSIZE];

	st_Buffer* m_pBufferFill;
	st_Buffer* m_pBufferWrite;
	UINT   m_nBufferFillIndex;

	//float m_Buffer1[ASYNCWRITE_BUFFERSIZE];
	//float m_Buffer2[ASYNCWRITE_BUFFERSIZE];

	//float* m_pBufferFill;
	//float* m_pBufferWrite;

	char m_szTaskSysTime[32];

	//double to char
	/*char roomT[1024];
	char waterT[1024];
	char s3[1024];
	char s4[1024];
	char s5[1024];
	char s6[1024];
	char s7[1024];
	char s8[1024];
	char s9[1024];
	char s10[1024];*/

	BOOL titleflag;
	//float Title[11];
	//float* p;
	string A = { "timestemp,roomtemp,watertemp,signal3,signal4,signal5,signal6,signal7,signal8,signal9,signal10" };
	char* Title = &A[0];

	ITcFileAccessAsyncPtr m_spFileAccessAsync; 
	
	CTcFsmFileWriter m_fsmFileWriter;
	CTcFsmFileWriter m_fsmFileTitleWriter;
};
