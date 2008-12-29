#!/usr/bin/env iospec

describe(webUser, WebUser,
	setup(
		user := WebUser clone
	)

	teardown(
		user = nil
	)

	webUser("should be in any roles assigned to it",
		user assignRole("assigned role")
		user verify(inRole("assigned role"))
	)

	webUser("should NOT be in any roles not assigned to it",
		user verify(inRole("assigned role") not)
	)
)

