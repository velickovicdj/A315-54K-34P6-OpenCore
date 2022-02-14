DefinitionBlock ("", "SSDT", 2, "HACK", "A315-54K", 0x00000000)
{
    External (_PR_.PR00, ProcessorObj)
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.GFX0, DeviceObj)
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (_SB_.PCI0.I2C1.TPAD, DeviceObj)
    External (XPRW, MethodObj)    // 2 Arguments

    Scope (\)
    {
    	Scope (_PR)
    	{
    		Scope (PR00)
    		{
    			If (_OSI ("Darwin"))
    			{
				    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
				    {
				        If ((Arg2 == Zero))
				        {
				            Return (Buffer (One)
				            {
				                 0x03                                             // .
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
    					Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
                        Name (_CID, "backlight")  // _CID: Compatible ID
                        Name (_UID, 0x10)  // _UID: Unique ID
                        Method (_STA, 0, NotSerialized)  // _STA: Status
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
    			Scope (LPCB)
    			{
			        Device (EC)
			        {
			            Name (_HID, "ACID0001")  // _HID: Hardware ID
			            Method (_STA, 0, NotSerialized)  // _STA: Status
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
    			Scope (I2C1.TPAD)
    			{
			        If (_OSI ("Darwin"))
				    {
				        Name (OSYS, 0x07DF)
				    }
    			}	
    		}
    		Device (USBX)
        	{
	            Name (_ADR, Zero)  // _ADR: Address
	            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
	            {
	                If ((Arg2 == Zero))
	                {
	                    Return (Buffer (One)
	                    {
	                         0x03                                             // .
	                    })
	                }

	                Return (Package (0x08)
	                {
	                    "kUSBSleepPowerSupply", 
	                    0x13EC, 
	                    "kUSBSleepPortCurrentLimit", 
	                    0x0834, 
	                    "kUSBWakePowerSupply", 
	                    0x13EC, 
	                    "kUSBWakePortCurrentLimit", 
	                    0x0834
	                })
	            }

	            Method (_STA, 0, NotSerialized)  // _STA: Status
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