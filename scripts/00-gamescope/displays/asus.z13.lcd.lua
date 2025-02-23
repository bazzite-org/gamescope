gamescope.config.known_displays.asusz13_lcd = {
    pretty_name = "Asus Z13 LCD",
    dynamic_refresh_rates = {
        48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 
        65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 
        82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 
        99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 
        113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 
        127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 
        141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 
        155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 
        169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180
    },
    
    -- Detailed Timing Descriptors:
    -- DTD 1:  1920x1200  120.002 Hz   8:5   151.683 kHz 315.500 MHz (172 mm x 107 mm)
    --   Modeline "1920x1200_120.00" 315.500  1920 1968 2000 2080  1200 1254 1260 1264  -HSync -VSync
    -- DTD 2:  1920x1200   60.001 Hz   8:5    75.841 kHz 157.750 MHz (172 mm x 107 mm)
    --   Modeline "1920x1200_60.00" 157.750  1920 1968 2000 2080  1200 1254 1260 1264  -HSync -VSync
    dynamic_modegen = function(base_mode, refresh)
        debug("Generating mode "..refresh.."Hz with fixed pixel clock")
        local vfps = {
            4886, 4751, 4620, 4495, 4375, 4259, 4147, 4040, 3936, 3836, 3739, 3646, 
            3556, 3468, 3384, 3302, 3223, 3146, 3072, 2999, 2929, 2861, 2795, 2731, 
            2668, 2608, 2548, 2491, 2435, 2380, 2327, 2275, 2225, 2175, 2127, 2080, 
            2035, 1990, 1946, 1903, 1862, 1821, 1781, 1742, 1704, 1667, 1630, 1594, 
            1559, 1525, 1491, 1458, 1426, 1395, 1364, 1333, 1303, 1274, 1245, 1217, 
            1190, 1162, 1136, 1110, 1084, 1059, 1034, 1010, 986, 962, 939, 916, 894,
            872, 850, 829, 808, 787, 767, 747, 727, 708, 689, 670, 652, 634, 616, 
            598, 581, 563, 547, 530, 513, 497, 481, 466, 450, 435, 420, 405, 390, 
            376, 361, 347, 333, 320, 306, 293, 279, 266, 254, 241, 228, 216, 204, 
            192, 180, 168, 156, 145, 133, 122, 111, 100, 89, 78, 68, 57, 47, 36, 
            26, 16, 6
        }
        local vfp = vfps[zero_index(refresh - 48)]
        if vfp == nil then
            warn("Couldn't do refresh "..refresh.." on ROG Ally")
            return base_mode
        end

        local mode = base_mode

        gamescope.modegen.adjust_front_porch(mode, vfp)
        mode.vrefresh = gamescope.modegen.calc_vrefresh(mode)

        --debug(inspect(mode))
        return mode
    end,
    matches = function(display)
        if display.vendor == "TMA" and display.model == "TL134ADXP03" then
            debug("[z13] Matched vendor: "..display.vendor.." model: "..display.model.." product:"..display.product)
            return 5000
        end
        return -1
    end
}
debug("Registered Lenovo Legion Go S LCD as a known display")