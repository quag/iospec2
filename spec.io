describe := method(
	if(call argCount == 1,
		stateSlotName := nil
		describedState := call evalArgAt(0) type
		bodyMessage := call argAt(1)
	,
		stateSlotName := call argAt(0) name
		describedState := call evalArgAt(1) type
		bodyMessage := call argAt(2)
	)

	bodyContext := Object clone

	if(stateSlotName,
		bodyContext setSlot(stateSlotName,
			method(shouldName,
				Lobby exampleCount = exampleCount + 1
				writeln(" - ", shouldName)

				testContext := Object clone
				try(call argAt(1) doInContext(testContext)) ?showStack
			)
		)
	)

	writeln(describedState)
	bodyMessage doInContext(bodyContext)
)

exampleCount := 0
failureCount := 0

writeln
time := Date cpuSecondsToRun(
	doFile(args at(1))
)

writeln
writeln("Finished in ", time, " seconds")
writeln
writeln(exampleCount, " examples, ", failureCount, " failures")
