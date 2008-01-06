describe(webUser, WebUser,

	webUser("should be in any roles assigned to it",
		user verify(roles contains("assigned role"))
	)
)
