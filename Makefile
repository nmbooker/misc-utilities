all: bin/intercalateEvery

bin/intercalateEvery: src/intercalateEvery.hs
	ghc -o bin/intercalateEvery src/intercalateEvery.hs

clean:
	$(RM) src/*.hi src/*.o
	$(RM) bin/intercalateEvery
