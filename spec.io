AssertionFailed := Exception clone

Object verify := method(
	if(self doMessage(call argAt(0), call sender),
		self
	,
		AssertionFailed raise(call argAt(0) code)
	)
)

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

				testContext := Object clone
				e := try(call argAt(1) doInContext(testContext))
				if(e,
					failureErrors append(e)
					writeln(" - ", shouldName, " [Error ", failureErrors size, "]")
				,
					writeln(" - ", shouldName)
				)
			)
		)
	)

	writeln(describedState)
	bodyMessage doInContext(bodyContext)
)

exampleCount := 0
failureErrors := list

writeln
time := Date cpuSecondsToRun(
	doFile(args at(1))
)
writeln

failureErrors foreach(i, error,
	write("Error ", i + 1, ":")
	error showStack
)
failureCount := failureErrors size

writeln("Finished in ", time, " seconds")
writeln
writeln(exampleCount, if(exampleCount == 1, " example, ", " examples, "), failureCount, if(failureCount == 1, " failure", " failures"))
