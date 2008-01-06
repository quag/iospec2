AssertionFailed := Exception clone

Object verify := method(
	if(self doMessage(call argAt(0), call sender),
		self
	,
		AssertionFailed raise(call argAt(0) code)
	)
)

BodyContext := Object clone do(
	newSlot("setupMessage", message(nil))
	newSlot("teardownMessage", message(nil))
	newSlot("parent", nil)
	newSlot("bodyContextName", nil)

	setup := method(
		setupMessage = call argAt(0)
	)

	teardown := method(
		teardownMessage = call argAt(0)
	)

	describe := method(
		if(call argCount == 1,
			stateSlotName := nil
			describedState := call evalArgAt(0)
			bodyMessage := call argAt(1)
		,
			stateSlotName := call argAt(0) name
			describedState := call evalArgAt(1)
			bodyMessage := call argAt(2)
		)

		if(describedState type != "Sequence",
			describedState = describedState type
		)

		bodyContext := BodyContext clone setParent(self)
		if(bodyContextName != nil,
			bodyContext setBodyContextName(bodyContextName .. " " .. describedState)
		,
			bodyContext setBodyContextName(describedState)
		)

		if(stateSlotName,
			bodyContext setSlot(stateSlotName,
				method(shouldName,
					Lobby exampleCount = exampleCount + 1

					testContext := Object clone
					e := try(
						describeContext := self
						describeContexts := list
						while(describeContext != nil,
							describeContexts prepend(describeContext)
							describeContext = describeContext parent
						)

						describeContexts foreach(setupMessage doInContext(testContext))
						call argAt(1) doInContext(testContext)
						describeContexts foreach(teardownMessage doInContext(testContext))
					)
					if(e,
						failureErrors append(e)
						writeln(" - ", shouldName, " [Error ", failureErrors size, "]")
					,
						writeln(" - ", shouldName)
					)
				)
			)
		)

		hasTests := false
		m := bodyMessage
		while(m != nil,
			if(m name == stateSlotName,
				hasTests = true
				break
			)
			m = m next
		)

		if(hasTests,
			writeln(bodyContext bodyContextName)
		)
		bodyMessage ?doInContext(bodyContext)
		if(hasTests,
			writeln
		)
	)
)


exampleCount := 0
failureErrors := list

writeln
time := Date cpuSecondsToRun(
	BodyContext clone doFile(args at(1))
)

failureErrors foreach(i, error,
	write("Error ", i + 1, ":")
	error showStack
)
failureCount := failureErrors size

writeln("Finished in ", time, " seconds")
writeln
writeln(exampleCount, if(exampleCount == 1, " example, ", " examples, "), failureCount, if(failureCount == 1, " failure", " failures"))
