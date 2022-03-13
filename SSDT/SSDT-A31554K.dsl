DefinitionBlock ("", "SSDT", 2, "VCDJ", "A315-54K", 0x00000000)
{
    External (_PR_.PR00, ProcessorObj)
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (_SB_.PCI0.GFX0, DeviceObj)
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.I2C0, DeviceObj)
    External (GPEN, FieldUnitObj)
    External (FMD1, FieldUnitObj)
    External (FMH1, FieldUnitObj)
    External (FML1, FieldUnitObj)
    External (OSYS, FieldUnitObj)
    External (SSD1, FieldUnitObj)
    External (SSH1, FieldUnitObj)
    External (SSL1, FieldUnitObj)
    External (XPRW, MethodObj)

    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            GPEN = 1
        }
    	Scope (_PR)
    	{
    		Scope (PR00)
    		{
    			If (_OSI ("Darwin"))
    			{
                    Method (_DSM, 4, NotSerialized)
                    {
                        If ((Arg2 == Zero))
                        {
                            Return (Buffer (One)
                            {
                                0x03
                            })
                        }
                        Return (Package (0x02)
                        {
                            "plugin-type", 
                            One
                        })
                    }
    			}
    		}
    	}
    	Scope (_SB)
    	{
    		Scope (PCI0)
    		{
    			Scope (GFX0)
    			{
    				Device (PNLF)
    				{
    					Name (_HID, EisaId ("APP0002"))
                        Name (_CID, "backlight")
                        Name (_UID, 16)
                        Method (_STA, 0, NotSerialized)
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0B)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
    				}
    			}
    			Scope (I2C0)
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
    			Scope (LPCB)
    			{
                    Device (ALS0)
                    {
                        Name (_HID, "ACPI0008")
                        Name (_CID, "smc-als")
                        Name (_ALI, 0x012C)
                        Name (_ALR, Package (0x01)
                        {
                            Package (0x02)
                            {
                                0x64,
                                0x012C
                            }
                        })
                        Method (_STA, 0, NotSerialized)
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }
                    Device (DMAC)
                    {
                        Name (_HID, EisaId ("PNP0200"))
                        Name (_CRS, ResourceTemplate ()
                        {
                            IO (Decode16,
                                0x0000,
                                0x0000,
                                0x01,
                                0x20,
                                )
                            IO (Decode16,
                                0x0081,
                                0x0081,
                                0x01,
                                0x11,
                                )
                            IO (Decode16,
                                0x0093,
                                0x0093,
                                0x01,
                                0x0D,
                                )
                            IO (Decode16,
                                0x00C0,
                                0x00C0,
                                0x01,
                                0x20,
                                )
                            DMA (Compatibility, NotBusMaster, Transfer8_16, )
                                {4}
                        })
                        Method (_STA, 0, NotSerialized)
                        {
                            If (_OSI ("Darwin"))
                            {
                                Return (0x0F)
                            }
                            Else
                            {
                                Return (Zero)
                            }
                        }
                    }
			        Device (EC)
			        {
			            Name (_HID, "ACID0001")
			            Method (_STA, 0, NotSerialized)
			            {
			                If (_OSI ("Darwin"))
			                {
			                    Return (0x0F)
			                }
			                Else
			                {
			                    Return (Zero)
			                }
			            }
			        }
    			}
                Device (MCHC)
                {
                    Name (_ADR, Zero)
                    Method (_STA, 0, NotSerialized)
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }
                Device (SBUS.BUS0)
                {
                    Name (_CID, "smbus")
                    Name (_ADR, Zero)
                    Device (DVL0)
                    {
                        Name (_ADR, 0x57)
                        Name (_CID, "diagsvault")
                        Method (_DSM, 4, NotSerialized)
                        {
                            If (!Arg2)
                            {
                                Return (Buffer (One)
                                {
                                     0x57
                                })
                            }
                            Return (Package (0x02)
                            {
                                "address", 
                                0x57
                            })
                        }
                    }
                    Method (_STA, 0, NotSerialized)
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }
                Device (MEM2)
                {
                    Name (_HID, EisaId ("PNP0C01"))
                    Name (_UID, 0x02)
                    Name (CRS, ResourceTemplate ()
                    {
                        Memory32Fixed (ReadWrite,
                            0x20000000,
                            0x00200000,
                            )
                        Memory32Fixed (ReadWrite,
                            0x40000000,
                            0x00200000,
                            )
                    })
                    Method (_CRS, 0, NotSerialized)
                    {
                        Return (CRS)
                    }
                    Method (_STA, 0, NotSerialized)
                    {
                        If (_OSI ("Darwin"))
                        {
                            Return (0x0F)
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }
                }	
    		}
    		Device (USBX)
        	{
	            Name (_ADR, Zero)
	            Method (_DSM, 4, NotSerialized)
	            {
	                If ((Arg2 == Zero))
	                {
	                    Return (Buffer (One)
	                    {
	                         0x03
	                    })
	                }
	                Return (Package (0x08)
	                { 
	                    "kUSBSleepPortCurrentLimit", 
	                    0x0BB8, 
	                    "kUSBWakePortCurrentLimit", 
	                    0x0BB8
	                })
	            }
	            Method (_STA, 0, NotSerialized)
	            {
	                If (_OSI ("Darwin"))
	                {
	                    Return (0x0F)
	                }
	                Else
	                {
	                    Return (Zero)
	                }
	            }
        	}
    	}
    	Method (GPRW, 2, NotSerialized)
    	{
	        If (_OSI ("Darwin"))
	        {
	            If ((0x6D == Arg0))
	            {
	                Return (Package (0x02)
	                {
	                    0x6D, 
	                    Zero
	                })
	            }
	            If ((0x0D == Arg0))
	            {
	                Return (Package (0x02)
	                {
	                    0x0D, 
	                    Zero
	                })
	            }
	        }
	        Return (XPRW (Arg0, Arg1))
    	}
    }
}