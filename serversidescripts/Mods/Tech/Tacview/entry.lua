local self_ID = "Tacview by Raia Software"

declare_plugin(self_ID,
{
	image		 = "Tacview.png",
	installed	 = true, -- if false that will be place holder , or advertising
	dirName		 = current_mod_path,
	binaries	 =
	{
--		'Tacview',
	},
	load_immediately = true,

	displayName	 = "Tacview",
	shortName	 = "Tacview",
	fileMenuName = "Tacview",

	version		 = "1.8.6.201",
	state		 = "installed",
	developerName= "Raia Software Inc.",
	info		 = _("Tacview is a universal flight analysis tool which enables you to record, analyze, and understand any flight to improve your skills much faster than with conventional debriefings. From the novice pilot to the virtual squadron leader, it is an invaluable tool to understand what really happened and to improve piloting style and tactical skills."),

	Skins	=
	{
		{
			name	= "Tacview",
			dir		= "Theme"
		},
	},

	Options =
	{
		{
			name		= "Tacview",
			nameId		= "Tacview",
			dir			= "Options",
			CLSID		= "{Tacview options}"
		},
	},
})

plugin_done()