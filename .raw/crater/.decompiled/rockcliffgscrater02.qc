// Created by Crowbar 0.72

$modelname "TheMask\SBMP\Nature\rocks\rockcliffgscrater02.mdl"

$staticprop

$bodygroup "Body"
{
	studio "rockcliffgscrater02.smd"
}


$surfaceprop "default"

$contents "solid"

$illumposition 260.415 69.39 -88.56

$mostlyopaque

$cdmaterials "TheMask\SBMP\Nature\F4_shared\"

$cbox 0 0 0 0 0 0

$bbox -894.24 -447.93 -490.32 755.46 968.76 313.2


$sequence "Idle" {
	"rockcliffgscrater02_anim_@Idle.smd"
	activity "ACT_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}
