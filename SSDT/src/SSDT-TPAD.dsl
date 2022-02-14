DefinitionBlock ("", "SSDT", 2, "hack", "TPAD", 0x00000000)
{
    External (_SB_.PCI0.I2C1.TPAD, DeviceObj)

    Scope (_SB.PCI0.I2C1.TPAD)
    {
        If (_OSI ("Darwin"))
        {
            Name (OSYS, 0x07DF)
        }
    }
}