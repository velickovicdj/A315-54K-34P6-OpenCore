DefinitionBlock ("", "SSDT", 2, "VCDJ", "TPAD", 0x00000000)
{
    External (_SB_.PCI0.I2C0, DeviceObj)
    External (FMD1, FieldUnitObj)
    External (FMH1, FieldUnitObj)
    External (FML1, FieldUnitObj)
    External (OSYS, FieldUnitObj)
    External (SSD1, FieldUnitObj)
    External (SSH1, FieldUnitObj)
    External (SSL1, FieldUnitObj)

    Scope (_SB.PCI0.I2C0)
    {
        Method (_INI, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                OSYS = 0x07DF
            }
        }
        Method (PKG3, 3, Serialized)
        {
            Name (PKG, Package (0x03)
            {
                Zero, 
                Zero, 
                Zero
            })
            PKG [Zero] = Arg0
            PKG [One] = Arg1
            PKG [0x02] = Arg2
            Return (PKG)
        }
        Method (SSCN, 0, NotSerialized)
        {
            Return (PKG3 (SSH1, SSL1, SSD1))
        }
        Method (FMCN, 0, NotSerialized)
        {
            Return (PKG3 (FMH1, FML1, FMD1))
        }
    }
}