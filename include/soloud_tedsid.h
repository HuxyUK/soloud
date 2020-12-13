/*
TED/SID module for SoLoud audio engine
Copyright (c) 2013-2015 Jari Komppa

This software is provided 'as-is', without any express or implied
warranty. In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

   1. The origin of this software must not be misrepresented; you must not
   claim that you wrote the original software. If you use this software
   in a product, an acknowledgment in the product documentation would be
   appreciated but is not required.

   2. Altered source versions must be plainly marked as such, and must not be
   misrepresented as being the original software.

   3. This notice may not be removed or altered from any source
   distribution.
*/

#ifndef TEDSID_H
#define TEDSID_H

#include "soloud.h"

class SIDsound;
class TED;

namespace SoLoud
{
	class TedSid;
	class File;

	class TedSidInstance : public AudioSourceInstance
	{
		TedSid *mParent;		
		SIDsound *mSID;
		TED *mTED;
		int mPos;
		unsigned int mSampleCount;
		std::array<int,128> mRegValues;
	public:

		explicit TedSidInstance(TedSid *aParent);
		~TedSidInstance() override;
		unsigned int getAudio(float *aBuffer, unsigned int aSamplesToRead, unsigned int aBufferSize) override;
		virtual void tick();
    bool hasEnded() override;
		float getInfo(unsigned int aInfoKey) override;
	};

	class TedSid : public AudioSource
	{
	public:
		int mLooppos;
		int mLength;
		unsigned short* mOps;
		int mModel;
		TedSid();
		~TedSid() override;
		result load(const char *aFilename);
		result loadMem(const unsigned char *aMem, unsigned int aLength, bool aCopy = false, bool aTakeOwnership = true);
		result loadFile(File *aFile);
		AudioSourceInstance *createInstance() override;
	};
};

#endif
