#pragma once

#include "TcFileAccessInterfaces.h"
#include "TcFsmFile.h"

enum eFileWriteState
{
	FileWriteError,
	FileWriteInit,
	FileWriteCheck,
	FileWriteFinished
};

class CTcFsmFileWrite : public TTcFsmFile<eFileWriteState>
{
public: 
	CTcFsmFileWrite();
	HRESULT Init
	(
		ITComObjectServer* ipSrv, 
		ITcFileAccessAsync* ipFileAccessAsync, 
		TcFileHandle hFileWrite, 
		PVOID pFileWriteBuffer, 
		ULONG nWriteBuffer
	);
	HRESULT Eval();

	// output 
	UINT GetFileWriteActually() const { return m_nFileWriteActually; }

private: 
	TcFileHandle m_hFileWrite;
	PVOID        m_pFileWriteBuffer;
	UINT         m_nFileWriteBuffer;
	UINT         m_nFileWriteActually;
};