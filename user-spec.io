describe(webUser, WebUser,

	webUser("should be in any roles assigned to it",
		user := WebUser clone
		user assignRole("assigned role")
		user verify(inRole("assigned role"))
	)

	webUser("should NOT be in any roles not assigned to it",
		user := WebUser clone
		user verify(inRole("assigned role") not)
	)
)
