declare_plugin("LotAtc 4 DCS by DArt",
{
image        = "LOTATC.bmp",
installed    = true, -- if false that will be place holder , or advertising
dirName      = current_mod_path,
binaries   =
{
    "Qt5Corelotatc",
    "Qt5Sqllotatc",
    "Qt5Positioninglotatc",
    "Qt5Networklotatc",
    "lotatc"
},
load_immediately = true,

shortName = 'LotAtc 4 DCS',
fileMenuName = _("LotAtc 4 DCS"),
version    = "2.2.1",
state    = "installed",
info     = _("LotAtc 4 DCS is a software that allows you to simulate the role of an air traffic controller (namely, first, an Air Defense controller). LotAtc shows the tactical situation (aircraft, SAMs, boats) on a 'radar screen' with a map background. As a virtual controller, you will be able to guide human virtual pilots in DCS World multiplayer missions, by radioing them (through your regular voice software such as Teamspeak, Mumble ... etc), whether to make them find their way and/or their leader, set up to your fighters to intercept bandits, or press the muds to hide or take shelter given what happens in front of them."),

Skins =
  {
    {
      name  = _("LotAtc 4 DCS"),
      dir   = "Skins/1"
    },
  },
Missions =
	{
		{
			name	= _("LotAtc 4 DCS"),
			dir		= "Missions",
  		},
	},
Options =
  {
    {
      name    = _("LotAtc 4 DCS"),
      nameId    = "LotAtc",
      dir     = "Options"
      --CLSID   = "{AE699235-F088-402f-93C9-B0FCB0E4A2ED}"
    },
  },
})
----------------------------------------------------------------------------------------
plugin_done()
