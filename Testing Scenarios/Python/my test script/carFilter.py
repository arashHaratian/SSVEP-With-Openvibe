import numpy

class MyOVBox(OVBox):
	def __init__(self):
		 OVBox.__init__(self)
		 self.signalHeader = None
			
	def initialize(self):
		return

	def process(self):
		for chunkIndex in range(len(self.input[0])):
			if(type(self.input[0][chunkIndex]) == OVSignalHeader):
				self.signalHeader = self.input[0].pop()
				
				outputHeader = OVSignalHeader(
				self.signalHeader.startTime, 
				self.signalHeader.endTime, 
				[1, self.signalHeader.dimensionSizes[1]], 
				['Mean']+self.signalHeader.dimensionSizes[1]*[''],
				self.signalHeader.samplingRate)

				self.output[0].append(outputHeader)
			
			elif(type(self.input[0][chunkIndex]) == OVSignalBuffer):
				chunk = self.input[0].pop()
				numpyBuffer = numpy.array(chunk)
				mu = numpyBuffer.mean()
				for index in range(len(numpyBuffer)):
					row = numpyBuffer[index]
					
					numpyBuffer[index] = row - mu

				chunk = OVSignalBuffer(chunk.startTime, chunk.endTime, numpyBuffer.tolist())
				self.output[0].append(chunk)
				
			elif(type(self.input[0][chunkIndex]) == OVSignalEnd):
				self.output[0].append(self.input[0].pop())	 



	def uninitialize(self):
		# nop
		return

box = MyOVBox()
