WebUser := Object clone do(
	lazySlot("roles", list)

	inRole := method(role,
		roles contains(role)
	)

	assignRole := method(role,
		roles append(role)
	)
)
