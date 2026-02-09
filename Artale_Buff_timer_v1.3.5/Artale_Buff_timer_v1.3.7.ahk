#Requires AutoHotkey v2.0

/*
變數縮寫
Num := number
LV := ListView
DDL := DropDownList
HK := HotKey
ContT := continue_time
CD := cooldown
Trig := trigger
IAdv := In_advansce
SE := sound_effect
FWin := floating_window
CBox := CheckBox
SW := Switch
temp := temporary
Addr := address
btn := Button
LOC := location
SL := Slider
PROG := Progress
*/

global_variables_setting()
MainGui := Gui("-Resize", 'Artale_Buff_timer_v1.3.7')
MainGui.SetFont("s16","微軟正黑體")
;Tab := MainGui.Add("Tab3",, ["技能界面", "設定"])
;MainGui.BackColor := 0xF0F0F0
;重置全部timer熱鍵
;只在MSW窗口存在時啟用

;-----MainGui_Construct_tab1_角色1
Tab_main_tabs := MainGui.Add("Tab3"," xm-13 ym-10 w640 h560 BackgroundF0F0F0 Choose1", ["設定檔切換","技能設定","懸浮窗設定","其他設定"])
Tab_main_tabs.OnEvent("Change", Selected_SL_slot_preview_reflash)
Selected_SL_slot_preview_reflash(Ctrl,Item) {
    if(Ctrl.Value == 1) {
        global Num_Selecting_SL_slot
        if (Num_Selecting_SL_slot == arr_tab1_last_closed_Setting[1]) {
            SL_slot_slecetd(arr_tab1_last_closed_Setting[1])
        }
    }
}
Tab_main_tabs.UseTab(2)
;~~~~~
MainGui.Add("GroupBox", "xm+0 ym+80 w280 h460 Section", "　　　　")
MainGui.Add("text","xs+8 ys+0 Backgroundtrans","技能列表").SetFont("c0000F0")
LV_setted_buff_list := MainGui.Add("ListView", "xs+10 ys+35 w260 h346 r15 -Multi +NoSort", ["No.","buffname","key"])
Create_framegui_like_Edit("xs+", 7, "y+", 9 , 260, 43,, 1)
Btn_add_new_LVdata1 := MainGui.Add("Button", "xp+4 yp+4 w58 h35", "新增")
MainGui.Add("Text", "0x11 x+4 yp+2 w1 h35") ; 0x10 橫分隔線 0x11 = 豎分割线
Btn_moveup_LVdata1 := MainGui.Add("Button", "x+4 yp-2 w58 h35", "上移")
Btn_movedown_LVdata1 := MainGui.Add("Button", "x+2 yp+0 w58 h35", "下移")
MainGui.Add("Text", "0x11 x+4 yp+2 w1 h35") ; 0x10 橫分隔線 0x11 = 豎分割线
Btn_delete_LVdata1 := MainGui.Add("Button", "x+4 yp-2 w58 h35", "移除")

; MainGui.Add("Text", "0x10 xs+12 y+10 w260 h1") ; 0x10 橫分隔線 0x11 = 豎分割线

; MainGui.Add("Text", "0x10 xp+0 y+13 w64 h1")

;-----LV_part_OnEvent
Btn_add_new_LVdata1.OnEvent("Click", LV_Added_newdata)
LV_setted_buff_list.OnEvent("ItemSelect",LV_ItemSelected)
Btn_delete_LVdata1.OnEvent("Click", LV_delete_data)
Btn_moveup_LVdata1.OnEvent("Click", LV_moveup_data)
Btn_movedown_LVdata1.OnEvent("Click", LV_movedown_data)
;~~~~~
MainGui.Add("GroupBox", "xm+305 ym+80 w310 h275 Section", "　　　　")
MainGui.Add("text","xs+8 ys+0 Backgroundtrans","技能設定").SetFont("c0000F0")
; MainGui.Add("Text", "xm+300 ym+80", "快速技能表：") ;.OnEvent("DoubleClick", fill_array2d_AllLV_data_toLV)
MainGui.Add("Text", "xs+12 ys+35 ", "技能按鍵：")
DDL_Buff_HK1 := MainGui.Add("DropDownList", "vDDL_Buff_HK1 x+0 yp-3 w165 h500", arr_AllKBKeys)
;PostMessage(0x153, -1, 27, DDL_Buff_HK1) ; 設定Str_Buff_HK1的框框高度
MainGui.Add("Text", "0x10 xs+12 y+3 w292 h1") ; 0x10 橫分隔線 0x11 = 豎分割线
MainGui.Add("Text", "xs+12 y+7 ", "技能名稱：") 
Str_Buff_name1 := MainGui.Add("edit", "vStr_Buff_name1 xp+105 yp-3 w150 h30", "")
MainGui.Add("Text", "xs+12 y+10 ", "持續時間：")
Num_ContT1 := MainGui.Add("edit", "vNum_ContT1 x+5 yp-3 w100 h30 +Number", "")
UpDown_ContT1 := MainGui.Add("UpDown", "vUpDown_ContT1 Range0-9999 +0x0080", 240) ;不插入千位分隔符+0x0080
MainGui.Add("Text", "x+5 yp+3", "秒(s)")
MainGui.Add("Text", "xs+12 y+10 Checked0", "總冷卻時間：")
Num_CDT1 := MainGui.Add("edit", "vNum_CDT1 x+5 yp-3 w100 h30 +Number", "")
MainGui.Add("UpDown", "vUpDown_CD1 Range0-9999 +0x0080", 360)
MainGui.Add("Text", "x+5 yp+3", "秒(s)")
MainGui.Add("Text", "0x10 xs+12 y+5 w292 h1") ; 0x10 橫分隔線 0x11 = 豎分割线
MainGui.Add("Text", "xs+12 y+10 ", "圖示位址：")
Btn_Pic_File_Path_Selecte := MainGui.Add("Button", "x+0 yp-4 w100 h35", "瀏覽檔案")
Pic_show_File_Selected := MainGui.Add("Picture", "vPic_show_File_Selected x+5 yp+3 w30 h30")
Btn_Pic_File_Path_clear := MainGui.Add("Button", "x+5 yp-3 w48 h35", "清空")
Path_Pic_File_Addr1 := MainGui.Add("edit", "vPath_Pic_Addr1 xs+16 y+1 w283 h40 +Multi +ReadOnly ", "")
Path_Pic_File_Addr1.SetFont("s10")
;~~~~~
Btn_show_Buff_list_win := mainGui.Add("Button", "xs+185 ys-5 w120 h35", "職業技能表")
back_Buff_list_2 := MainGui.Add("Text", "xm+400 ym+110 w212 h99 Background909090")
back_Buff_list_1 := MainGui.Add("Text", "xp+1 yp+1 w210 h97 BackgroundF0F0F0")
DDL_Buff_Class1 := MainGui.Add("DropDownList", "vDDL_Buff_Class1 xp+10 yp+10 w90 h370", arr_ALL_Classes)
Btn_Autofill_Buff_list_value := MainGui.Add("Button", "x+45 yp-1 w55 h37", "填入")
DDL_Buff_list1 := MainGui.Add("DropDownList", "vDDL_Buff_list1 xp-135 y+8 w130 h350", ["未選擇職業"])
Btn_hide_Buff_list_win := MainGui.Add("Button", "x+5 yp-1 w55 h37", "取消")
arrobj_Buff_list_win := Array(back_Buff_list_2, back_Buff_list_1, DDL_Buff_Class1, DDL_Buff_list1, Btn_Autofill_Buff_list_value, Btn_hide_Buff_list_win)
loop (arrobj_Buff_list_win.Length) {
    arrobj_Buff_list_win[A_Index].Visible := false
}
;-----buff_setting_part_OnEvent
Btn_show_Buff_list_win.OnEvent("Click",Buff_list_win_switch)
Btn_hide_Buff_list_win.OnEvent("Click",Buff_list_win_switch)
DDL_Buff_Class1.OnEvent("Change", DDL_Change_Classes_list)
DDL_Buff_list1.OnEvent("Change", DDL_Change_Buff_list)
Btn_Autofill_Buff_list_value.OnEvent("Click", Autofill_Buff_list_value)
Str_Buff_name1.OnEvent("Change", buff_setting_unsafed_check)
DDL_Buff_HK1.OnEvent("Change", start_check_is_no_same_hotkey)
DDL_Buff_HK1.OnEvent("Change", buff_setting_unsafed_check)
Num_ContT1.OnEvent("Change", buff_setting_unsafed_check)
Num_CDT1.OnEvent("Change", buff_setting_unsafed_check)
Btn_Pic_File_Path_Selecte.OnEvent("Click", Pic_File_Path_Selecte)
Btn_Pic_File_Path_clear.OnEvent("Click", Pic_File_Path_clear)

;~~~~~
MainGui.Add("GroupBox", "xs+0 ys+275 w310 h185 Section", "　　　　")
MainGui.Add("text","xs+8 ys+0 Backgroundtrans","音效提醒").SetFont("c0000F0")
Bool_BuffEnd_SE_Trig1 := MainGui.Add("CheckBox", "vCBox_BuffEnd_SE_Trig1 xs+14 ys+35", "技能持續結束")
MainGui.Add("Text", "x+0 yp+0", "前")
Num_BuffEnd_SE_IAdv1 := MainGui.Add("edit", "vNum_BuffEnd_SE_IAdv1 x+3 yp-3 w60 h30 +number", "")
MainGui.Add("UpDown", "vUpDown_BuffEnd_SE_IAdv1 Range0-9999 +0x0080", 0)
MainGui.Add("Text", "x+5 yp+3", "秒(s)")
MainGui.Add("Text","xs+12 y+10","類型")
DDL_BuffEnd_SE_type1 := MainGui.Add("DropDownList", "vDDL_BuffEnd_SE_type1 x+5 yp-5 w95 h260", arr_SE_types)
;PostMessage(0x153, -1, 27, DDL_BuffEnd_SE_type1) ; 設定框框高度
MainGui.Add("Text","x+10 yp+5","音高")
DDL_BuffEnd_SE_Pitch1 := MainGui.Add("DropDownList", "vDDL_BuffEnd_SE_Pitch1 x+5 yp-5 w95 h500", arr_pitch_names)
Btn_select_BuffEnd_wav := MainGui.Add("Button", "xs+155 yp-0 w55 h35", "瀏覽")
Str_selected_BuffEnd_wav := MainGui.Add("edit", "x+2 yp+0 w95 h35 +ReadOnly ", "")
Str_selected_BuffEnd_wav.SetFont("s10")
Btn_select_BuffEnd_wav.Visible := false
Str_selected_BuffEnd_wav.Visible := false
MainGui.Add("Text", "0x10 xs+10 y+2 w292 h1") ; 0x10 橫分隔線 0x11 = 豎分割线
; MainGui.Add("Text", "xs+10 y+5", "時音效提醒：")
Bool_CD_SE_Trig1 := MainGui.Add("CheckBox", "vCBox_CD_SE_Trig1 xs+14 y+9 Checked", "冷卻時間結束")
MainGui.Add("Text", "x+0 yp+0", "前")
Num_CD_SE_IAdv1 := MainGui.Add("edit", "vNum_CD_SE_IAdv1 x+3 yp-3 w60 h30 +number", "")
MainGui.Add("UpDown", "vUpDown_CD_SE_IAdv1 Range0-9999 +0x0080", 0)
MainGui.Add("Text", "x+5 yp+3", "秒(s)")
MainGui.Add("Text","xs+12 y+10","類型")
DDL_CD_SE_type1 := MainGui.Add("DropDownList", "vDDL_CD_SE_type1 x+5 yp-5 w95 h260", arr_SE_types)
;PostMessage(0x153, -1, 27, DDL_CD_SE_type1) ; 設定框框高度
MainGui.Add("Text","x+10 yp+5","音高")
DDL_CD_SE_Pitch1 := MainGui.Add("DropDownList", "vDDL_CD_SE_Pitch1 x+5 yp-5 w95 h500", arr_pitch_names)
Btn_select_CD_wav := MainGui.Add("Button", "xs+155 yp-0 w55 h35", "瀏覽")
Str_selected_CD_wav := MainGui.Add("edit", "x+2 yp+0 w95 h35 +ReadOnly ", "")
Str_selected_CD_wav.SetFont("s10")
Btn_select_CD_wav.Visible := false
Str_selected_CD_wav.Visible := false
;-----SE_setting_part_OnEvent
Bool_BuffEnd_SE_Trig1.OnEvent("click", BuffEnd_SE_option_enable)
Num_BuffEnd_SE_IAdv1.OnEvent("Change", buff_setting_unsafed_check)
DDL_BuffEnd_SE_type1.OnEvent("Change", setting_paly_beep_sound)
DDL_BuffEnd_SE_type1.OnEvent("Change", buff_setting_unsafed_check)
DDL_BuffEnd_SE_Pitch1.OnEvent("Change",setting_paly_beep_sound)
DDL_BuffEnd_SE_Pitch1.OnEvent("Change", buff_setting_unsafed_check)
Btn_select_BuffEnd_wav.OnEvent("click", select_wav_file)
Bool_CD_SE_Trig1.OnEvent("click", CD_SE_option_enable)
Num_CD_SE_IAdv1.OnEvent("Change", buff_setting_unsafed_check)
DDL_CD_SE_type1.OnEvent("Change",setting_paly_beep_sound)
DDL_CD_SE_type1.OnEvent("Change", buff_setting_unsafed_check)
DDL_CD_SE_Pitch1.OnEvent("Change",setting_paly_beep_sound)
DDL_CD_SE_Pitch1.OnEvent("Change", buff_setting_unsafed_check)
Btn_select_CD_wav.OnEvent("click", select_wav_file)


;~~~~~


back_Btn_save_buffsetting1 := MainGui.Add("Text","xm+274 ym+111 w37 h355 +Disabled") ;4位數字w40
Btn_save_buffsetting1 := MainGui.Add("Button", "xp+3 yp+3 w31 h349", "←`n←`n`n儲`n存`n技`n能`n設`n定`n`n←`n←`n")
Btn_save_buffsetting1.OnEvent("Click", fill_now_buffsetting_to_data_array)
;~~~~~show_DDL_selected_row
back_DDL_selected_row1_tab1 := MainGui.Add("Text","xm+4 ym+148 w5 h31 Background70ff70 ") ;4位數字w40
back_DDL_selected_row2_tab1 := MainGui.Add("Text","xp0 y+0 w5 h31 Background70ff70 ")
back_DDL_selected_row3_tab1 := MainGui.Add("Text","xp+0 y+0 w5 h31 Background70ff70 ")
back_DDL_selected_row4_tab1 := MainGui.Add("Text","xp+0 y+0 w5 h31 Background70ff70 ")
back_DDL_selected_row5_tab1 := MainGui.Add("Text","xp+0 y+0 w5 h31 Background70ff70 ")
back_DDL_selected_row6_tab1 := MainGui.Add("Text","xp+0 y+0 w5 h31 Background70ff70 ")
back_DDL_selected_row7_tab1 := MainGui.Add("Text","xp+0 y+0 w5 h31 Background70ff70 ")
back_DDL_selected_row8_tab1 := MainGui.Add("Text","xp+0 y+0 w5 h31 Background70ff70 ")
back_DDL_selected_row9_tab1 := MainGui.Add("Text","xp+0 y+0 w5 h31 Background70ff70 ")
back_DDL_selected_row10_tab1 := MainGui.Add("Text","xp+0 y+0 w5 h31 Background70ff70 ")
arrobj_all_back_DDL_selected_row_tab1 := [ 
    back_DDL_selected_row1_tab1, back_DDL_selected_row2_tab1,back_DDL_selected_row3_tab1,back_DDL_selected_row4_tab1,back_DDL_selected_row5_tab1,
    back_DDL_selected_row6_tab1,back_DDL_selected_row7_tab1,back_DDL_selected_row8_tab1,back_DDL_selected_row9_tab1,back_DDL_selected_row10_tab1
]
;將back_DDL_selected圖片的預設為不可見
loop (arrobj_all_back_DDL_selected_row_tab1.Length) {
    arrobj_all_back_DDL_selected_row_tab1[A_Index].Visible := false
    ;arrobj_all_Pic_child_tab1_slot[A_Index].Visible := false ;設定黑白layer2不可見
}

;~~~~~
Tab_main_tabs.UseTab(1)
;~~~~~
MainGui.Add("GroupBox", "xm+0 ym+80 w325 h460 Section", "　　　　　")
MainGui.Add("text","xs+9 ys+0 Backgroundtrans","設定檔管理").SetFont("c0000F0")

;-----建立SL_slot與其名稱text
SL_btn_width := 300, SL_btn_height := 34, SL_btn_gap := 5
arrobj_back_SL_slot := [], arrobj_text_SL_slot_name := [], arrobj_back_SL_slot_frame := []

arrobj_back_SL_slot_frame.push (MainGui.Add("text", "xs+9 ys+32 w" SL_btn_width + 8 " h" SL_btn_height + 8 " Background70ff70"))
arrobj_back_SL_slot_frame[1].visible := false
Create_framegui_like_Edit("xs+", 12, "ys+", 35 , SL_btn_width, SL_btn_height, &arrobj_back_SL_slot)
MainGui.Add("text", "xp+10 yp+4 w35 h30 BackgroundTrans","1：")
arrobj_text_SL_slot_name.push (MainGui.Add("text", "x+0 yp w255 h30 BackgroundTrans","buff_setting_1"))
loop (7) {
    arrobj_back_SL_slot_frame.push (MainGui.Add("text", "xp-49 y+4 w" SL_btn_width + 8 " h" SL_btn_height + 8 " Background70ff70"))
    arrobj_back_SL_slot_frame[A_Index+1].visible := false    
    Create_framegui_like_Edit("xp+", 3, "yp+", -2 + SL_btn_gap, SL_btn_width, SL_btn_height, &arrobj_back_SL_slot)
    MainGui.Add("text", "xp+10 yp+4 w35 h30 BackgroundTrans", A_Index+1 "：")
    arrobj_text_SL_slot_name.push (MainGui.Add("text", "x+0 yp w255 h30 BackgroundTrans"))
}

Create_framegui_like_Edit("xs+", 13, "y+", 10 , 294, 45,, 1)
back_saved_settting_enable := MainGui.Add("text","xp+3 yp+3 w64 h39")
btn_saved_settting_enable := MainGui.Add("Button","xp+2 yp+2 w60 h35","應用")
MainGui.Add("Text", "0x11 x+9 yp+2 w1 h35")
btn_saved_settting_Import := MainGui.Add("Button","x+9 yp-2 w60 h35","匯入")
btn_saved_settting_Export := MainGui.Add("Button","x+6 yp w60 h35","匯出")
btn_saved_settting_Newfile := MainGui.Add("Button","xp+0 yp+0 w60 h35","新建")
btn_saved_settting_Newfile.Visible := false
MainGui.Add("Text", "0x11 x+9 yp+2 w1 h35")
btn_saved_settting_clear := MainGui.Add("Button","x+9 yp-2 w60 h35","清空")

;-----saved_settting_SL_slot_part_OnEvent
arrobj_back_SL_slot[1].OnEvent("click", (*) => SL_slot_slecetd(1))
arrobj_back_SL_slot[2].OnEvent("click", (*) => SL_slot_slecetd(2))
arrobj_back_SL_slot[3].OnEvent("click", (*) => SL_slot_slecetd(3))
arrobj_back_SL_slot[4].OnEvent("click", (*) => SL_slot_slecetd(4))
arrobj_back_SL_slot[5].OnEvent("click", (*) => SL_slot_slecetd(5))
arrobj_back_SL_slot[6].OnEvent("click", (*) => SL_slot_slecetd(6))
arrobj_back_SL_slot[7].OnEvent("click", (*) => SL_slot_slecetd(7))
arrobj_back_SL_slot[8].OnEvent("click", (*) => SL_slot_slecetd(8))
btn_saved_settting_enable.OnEvent("Click",enable_saved_settting)
btn_saved_settting_Import.OnEvent("Click",Import_saved_settting)
btn_saved_settting_Export.OnEvent("Click",Export_saved_settting)
btn_saved_settting_Newfile.OnEvent("Click",Create_New_saved_settting)
btn_saved_settting_clear.OnEvent("Click",clear_saved_settting)

SL_slot_slecetd(slot_num) {
    global arr2d_preview_tab1_AllLV_data, num_Selecting_SL_slot := slot_num
    loop (arrobj_back_SL_slot.Length) {
        if (num_Selecting_SL_slot == A_Index) {
            Fwin_text_color_changed(arrobj_back_SL_slot[A_Index],"back","F8F8F8")
        }
        else {
            Fwin_text_color_changed(arrobj_back_SL_slot[A_Index],"back","F0F0F0")
        }
    }   
    local file_Path := arr_tab1_each_buff_setting_path[num_Selecting_SL_slot]
    if (FileExist(file_Path)
    and !RegExMatch(file_Path, "[;``]")
    and check_buff_settings_format(,file_Path) == true) { 
        arr2d_preview_tab1_AllLV_data := load_from_ini("arr2d_tab1_AllLV_data", 2,, file_Path).Clone()
        arr_preview_tab1_Other_Setting_data := load_from_ini("arr_tab1_Other_Setting_data", 1,,file_Path).Clone()
        fill_array2d_preview_AllLV_data_toLV()
        if (arr_preview_tab1_Other_Setting_data[1] == "" or arr_preview_tab1_Other_Setting_data[1] == "non") {
            text_preview_reset_timer_HK.Value := ""
        }
        else {
            text_preview_reset_timer_HK.Value := arr_preview_tab1_Other_Setting_data[1]
        }
        if (arr_preview_tab1_Other_Setting_data[2] == "" or arr_preview_tab1_Other_Setting_data[2] == "non") {
            text_preview_hide_maingui_HK.Value := ""
        }
        else {
            text_preview_hide_maingui_HK.Value := arr_preview_tab1_Other_Setting_data[2]
        }
        if (arr_preview_tab1_Other_Setting_data[3] == "" or arr_preview_tab1_Other_Setting_data[3] == "non") {
            text_preview_reload_script_HK.Value := ""
        }
        else {
            text_preview_reload_script_HK.Value := arr_preview_tab1_Other_Setting_data[3]
        }
        btn_saved_settting_enable.Opt("-Disabled")
        btn_saved_settting_Export.Visible := true
        btn_saved_settting_Export.Opt("-Disabled")
        btn_saved_settting_clear.Opt("-Disabled")
        btn_saved_settting_Newfile.Visible := false
    }
    else {
    LV_preview_buff_list.Delete()
    text_preview_reset_timer_HK.Value := ""
    text_preview_hide_maingui_HK.Value := ""
    text_preview_reload_script_HK.Value := ""
    btn_saved_settting_enable.Opt("+Disabled")
    btn_saved_settting_Export.Visible := false
    btn_saved_settting_Export.Opt("+Disabled")
    btn_saved_settting_clear.Opt("+Disabled")
    btn_saved_settting_Newfile.Visible := true
    }
}

fill_array2d_preview_AllLV_data_toLV(*) {
    global arr2d_preview_tab1_AllLV_data
    local arr_temp_datafill := ["",""] ; arr_newdata_set.Clone()
    local count_x := 1
    LV_preview_buff_list.Delete()
    while (count_x <= 10 and arr2d_preview_tab1_AllLV_data[count_x][1] != "") {
        count_y := 1
        for count_y, Length in arr_temp_datafill {
            arr_temp_datafill[count_y] := arr2d_preview_tab1_AllLV_data[count_x][count_y]
        }
        ;sgbox "count_x " count_x "`nname " arr_temp_datafill[1] "`nkey " arr_temp_datafill[2]
        LV_preview_buff_list.add("", count_x, arr_temp_datafill[1], arr_temp_datafill[2])
    ++count_x
    }
    LV_preview_buff_list.ModifyCol(2,"AutoHdr") ;依照內容調整第二行寬度
    LV_preview_buff_list.ModifyCol(3,"AutoHdr") ;依照內容調整第三行寬度
}

MainGui.Add("GroupBox", "xm+335 ym+80 w280 h460 Section", "　　　　　")
MainGui.Add("text","xs+9 ys+0 Backgroundtrans","設定檔預覽").SetFont("c0000F0")
LV_preview_buff_list := MainGui.Add("ListView", "xs+10 ys+35 w260 h346 r15 -Multi +NoSort", ["No.","buffname","key"])
MainGui.Add("Text", "xs+10 y+5 w120","重置全部計時：").SetFont("s12")
text_preview_reset_timer_HK := MainGui.Add("Text", "x+0 yp w165 h20","")
text_preview_reset_timer_HK.SetFont("s12")
MainGui.Add("Text", "xs+10 y+1 w120","隱藏設定視窗：").SetFont("s12")
text_preview_hide_maingui_HK := MainGui.Add("Text", "x+0 yp w165 h20","")
text_preview_hide_maingui_HK.SetFont("s12")
MainGui.Add("Text", "xs+10 y+1 w120","重新啟動程式：").SetFont("s12")
text_preview_reload_script_HK := MainGui.Add("Text", "x+0 yp w165 h20","")
text_preview_reload_script_HK.SetFont("s12")

;~~~~~
Tab_main_tabs.UseTab(3)
;~~~~~建立FWin_settting_Tab分頁
MainGui.Add("GroupBox", "xm+0 ym+80 w315 h460 Section", "　　　　　")
MainGui.Add("text","xs+8 ys+0 Backgroundtrans","懸浮窗設定").SetFont("c0000F0")
;~~~~~
Bool_FWin_SW1 := MainGui.Add("CheckBox", "vCBox_FWin_SW1 xs+14 ys+35 Checked", "啟用")
MainGui.Add("Text", "0x11 x+4 yp+2 w1 h25")
Bool_move_FWin := MainGui.Add("Radio", "vBool_move_arrow_SW1 x+16 yp-2 Checked", "移動")
Bool_lock_FWin := MainGui.Add("Radio", "vBool_lock_FWin x+20 yp+0", "鎖定")
MainGui.Add("Text", "xp-20 yp+0", "/")

MainGui.Add("Text", "0x10 xs+10 y+6 w297 h1") ; 0x10 橫分隔線 0x11 = 豎分割线

MainGui.Add("Text","xs+12 y+8","位置座標：")
MainGui.Add("Text","xs+14 y+10","Ｘ值")
Num_FWin_now_Xaxis := MainGui.Add("edit", "vNum_FWin_now_Xaxis x+5 yp-2 w75 h30", 640)
MainGui.Add("UpDown", "Range-640-7680  +0x0080", 640)
MainGui.Add("Text","xs+152 yp+2","Ｙ值")
Num_FWin_now_Yaxis := MainGui.Add("edit", "vNum_FWin_now_Yaxis x+5 yp-2 w75 h30", 360)
MainGui.Add("UpDown", "Range-480-4320 +0x0080", 360)

MainGui.Add("Text", "0x10 xs+10 y+8 w297 h1") ; 0x10 橫分隔線 0x11 = 豎分割线

MainGui.Add("Text","xs+12 y+8","技能圖示：")
MainGui.Add("Text","xs+14 y+10","大小")
Num_Fwin_Pic_size1 := MainGui.Add("edit", "vNum_Fwin_Pic_Scale1 x+5 yp-2 w62 h30 +number", "40")
MainGui.Add("UpDown", "Range20-9999 +0x0080", 40)
;PostMessage(0x153, -1, 25, Num_Fwin_Pic_size1) ; 設定框框高度
;SL_Fwin_Pic_Scale1 := MainGui.Add("Slider","x+15 yp+1 w150 Range1-8 Line1 Page1 TickInterval AltSubmit", 4)
MainGui.Add("Text","xs+152 yp+2","間距")
Num_Fwin_gap_of_Pic1 := MainGui.Add("edit", "vNum_Fwin_gap_of_Pic1 x+5 yp-2 w62 h30 +number", 0)
MainGui.Add("UpDown", "Range0-9999 +0x0080", 0)
;PostMessage(0x153, -1, 25, Num_Fwin_gap_of_Pic1) ; 設定框框高度

MainGui.Add("Text", "0x10 xs+10 y+8 w297 h1") ; 0x10 橫分隔線 0x11 = 豎分割线

MainGui.Add("Text","xs+12 y+8","時間數字：")
MainGui.Add("Text","xs+14 y+10","大小")
Num_Fwin_Time_Size1 := MainGui.Add("edit", "vNum_Fwin_Time_Size1 x+5 yp-2 w62 h30 +number", 12)
MainGui.Add("UpDown", "Range8-9999 +0x0080", 12)
;PostMessage(0x153, -1, 25, Num_Fwin_Time_Size1) ; 設定框框高度
MainGui.Add("Text","xs+152 yp+2","顏色")
CBB_Fwin_Time_num_color1 := MainGui.Add("ComboBox", "vCBB_Fwin_Time_num_color1 x+5 yp-4 w92 h500 Choose1", ["Black","Gray","Silver","F0F0F0","White","Red","Blue","Lime"])
;PostMessage(0x153, -1, 25, CBB_Fwin_Time_num_color1) ; 設定框框高度
back_exp_Fwin_Time_num_color1 := MainGui.Add("Text","xp+91 yp w6 h35 +Border",)
Fwin_text_color_changed(back_exp_Fwin_Time_num_color1, "back", CBB_Fwin_Time_num_color1.Text, 1)
MainGui.Add("Text","xs+14 y+9","位置")
DDL_Fwin_Time_Loc1 := MainGui.Add("DropDownList", "vDDL_Fwin_Time_Loc1 x+5 yp-4 w88 h500 Choose2", ["不顯示","左上方","左下方","左上角","左下角","右上方","右下方","右上角","右下角"])
;PostMessage(0x153, -1, 25, DDL_Fwin_Time_Loc1) ; 設定框框高度
MainGui.Add("Text","xs+152 yp+4","底色")
CBB_Fwin_Time_back_color1 := MainGui.Add("ComboBox", "vCBB_Fwin_Time_back_color1 x+5 yp-4 w92 h500 Choose5", ["不顯示","Black","Gray","Silver","F0F0F0","White","Red","Blue","Lime"])
;PostMessage(0x153, -1, 25, CBB_Fwin_Time_back_color1) ; 設定框框高度
back_exp_Fwin_Time_back_color1 := MainGui.Add("Text","xp+91 yp w6 h35 +Border",)
Fwin_text_color_changed(back_exp_Fwin_Time_back_color1, "back", CBB_Fwin_Time_back_color1.Text, 2)
MainGui.Add("Text", "0x10 xs+10 y+8 w297 h1") ; 0x10 橫分隔線 0x11 = 豎分割线
;~~~~~
Create_framegui_like_Edit("xs+", 35, "y+", 15 , 239, 45,, 1)
back_Btn_FWin_reflash := MainGui.Add("Text","xp+6 yp+3 w105 h39",)
Btn_FWin_reflash := MainGui.Add("Button", "xp+2 yp+2 w101 h35", "套用設定")
MainGui.Add("Text", "0x11 x+10 yp+2 w1 h35")
Btn_FWin_cancel_change := MainGui.Add("Button","x+10 yp-2 w101 h35","取消變更")


;-----Fwin_setting_1_part_OnEvent
Bool_move_FWin.OnEvent("Click", FWin_Location_unlock)
Bool_lock_FWin.OnEvent("Click", FWin_Location_lock)
;SL_Fwin_Pic_Scale1.OnEvent("Change", SL_Fwin_Pic_Scale_Changed)
Bool_FWin_SW1.OnEvent("Click",FWin_setting_unsafed_check)
Bool_move_FWin.OnEvent("Click",FWin_setting_unsafed_check)
Bool_lock_FWin.OnEvent("Click",FWin_setting_unsafed_check)
CBB_Fwin_Time_num_color1.OnEvent("change",FWin_setting_unsafed_check)
CBB_Fwin_Time_back_color1.OnEvent("change",FWin_setting_unsafed_check)
Num_FWin_now_Xaxis.OnEvent("change",FWin_setting_unsafed_check)
Num_FWin_now_Yaxis.OnEvent("change",FWin_setting_unsafed_check)
Num_Fwin_Pic_size1.OnEvent("change",FWin_setting_unsafed_check)
Num_Fwin_gap_of_Pic1.OnEvent("change",FWin_setting_unsafed_check)
Num_Fwin_Time_Size1.OnEvent("change",FWin_setting_unsafed_check)
DDL_Fwin_Time_Loc1.OnEvent("change",FWin_setting_unsafed_check)
CBB_Fwin_Time_num_color1.OnEvent("change", (*) => Fwin_text_color_changed(back_exp_Fwin_Time_num_color1, "back", CBB_Fwin_Time_num_color1.Text, 1))
CBB_Fwin_Time_back_color1.OnEvent("change", (*) => Fwin_text_color_changed(back_exp_Fwin_Time_back_color1, "back", CBB_Fwin_Time_back_color1.Text, 2))
Btn_FWin_reflash.OnEvent("Click", FWin_reflash)
; Btn_FWin_reflash.OnEvent("Click",FWin_setting_unsafed_check)
Btn_FWin_cancel_change.OnEvent("Click", FWin_cancel_change)
;~~~~~
MainGui.Add("GroupBox", "xm+325 ym+80 w290 h270 Section", "　　　　　")
MainGui.Add("text","xs+8 ys+0 Backgroundtrans","懸浮窗設定").SetFont("c0000F0")
MainGui.Add("Text"," xs+12 ys+35","顯示透明度(0-255)：")
MainGui.Add("Text"," xs+14 y+10","技能持續圖示")
Num_pic_trns_tab1 := MainGui.Add("edit", "vNum_pic_trns_tab1 x+5 yp-3 w70 h30 +number", "255")
MainGui.Add("UpDown", "Range0-255 +0x0080", 255)
MainGui.Add("Text"," xs+14 y+10","技能結束圖示")
Num_gray_pic_trns_tab1 := MainGui.Add("edit", "vNum_gray_pic_trns_tab1 x+5 yp-3 w70 h30 +number", "255")
MainGui.Add("UpDown", "Range0-255 +0x0080", 255)
MainGui.Add("Text"," xs+14 y+10","時間數字")
Num_time_trns_tab1 := MainGui.Add("edit", "vNum_time_trns_tab1 x+5 yp-3 w70 h30 +number", "255")
MainGui.Add("UpDown", "Range0-255 +0x0080", 255)

MainGui.Add("Text", "0x10 xs+10 y+8 w272 h1") ; 0x10 橫分隔線 0x11 = 豎分割线

MainGui.Add("Text"," xs+14 y+10","顯示分鐘(m)格式：")
MainGui.Add("Text"," xs+14 y+10","時間高於")
Num_time_show_mins := MainGui.Add("edit", "x+5 yp-3 w75 h30 +number", 600)
MainGui.Add("UpDown", "Range0-9999 +0x0080", 600)
MainGui.Add("Text","x+5 yp+3","秒(s)時")

;~~~~~


;-----Fwin_setting_2_part_OnEvent
Num_pic_trns_tab1.OnEvent("change",FWin_setting_unsafed_check)
Num_gray_pic_trns_tab1.OnEvent("change",FWin_setting_unsafed_check)
Num_time_trns_tab1.OnEvent("change",FWin_setting_unsafed_check)
Num_time_show_mins.OnEvent("change",FWin_setting_unsafed_check)

;~~~~~建立others_settting_Tab分頁
Tab_main_tabs.UseTab(4)
;~~~~
MainGui.Add("GroupBox", "xm+0 ym+80 w340 h460 Section", "　　　　")
MainGui.Add("text","xs+8 ys+0 Backgroundtrans","其他設定").SetFont("c0000F0")

MainGui.Add("Text"," xs+12 y+10","重置全部計時：")
DDL_reset_all_timer_HK1 := MainGui.Add("DropDownList", "vDDL_reset_all_timer_HK1 x+0 yp-3 w165 h500", arr_AllKBKeys)
;PostMessage(0x153, -1, 27, DDL_reset_all_timer_HK1) ; 設定框框高度
MainGui.Add("Text", "0x10 xs+10 y+4 w322 h1") ; 0x10 橫分隔線 0x11 = 豎分割线
MainGui.Add("Text","xs+12 y+8","隱藏設定視窗：")
DDL_hide_mainGUI_HK1 := MainGui.Add("DropDownList", "vDDL_hide_mainGUI_HK1 x+0 yp-3 w165 h500", arr_AllKBKeys)
;PostMessage(0x153, -1, 27, DDL_hide_mainGUI_HK1) ; 設定框框高度
MainGui.Add("Text", "0x10 xs+10 y+4 w322 h1") ; 0x10 橫分隔線 0x11 = 豎分割线
MainGui.Add("Text","xs+12 y+8","重新啟動程式：")
DDL_reload_script_HK1 := MainGui.Add("DropDownList", "vDDL_reload_script_HK1 x+0 yp-3 w165 h500", arr_AllKBKeys)
;PostMessage(0x153, -1, 27, DDL_reload_script_HK1) ; 設定框框高度
MainGui.Add("Text", "0x10 xs+10 y+4 w322 h1") ; 0x10 橫分隔線 0x11 = 豎分割线
Bool_enable_when_winactive_Trig1 := MainGui.Add("CheckBox", "vBool_enable_when_winactive_Trig1 xs+14 y+8 Checked", "僅在以下視窗啟用按鍵：")
str_winactive_name1 := MainGui.Add("edit", "vstr_winactive_name1 xs+12 y+5 w315 h25", "MapleStory Worlds-Artale (繁體中文版)")
str_winactive_name1.SetFont("s12")
MainGui.Add("Text", "0x10 xs+12 y+10 w322 h1") ; 0x10 橫分隔線 0x11 = 豎分割线
Bool_CD_resettable_Trig1 := MainGui.Add("CheckBox", "vCBox_CD_resettable_Trig1 xs+14 y+6", "使冷卻中技能按鍵無效")
MainGui.Add("Text", "0x10 xs+12 y+5 w322 h1") ; 0x10 橫分隔線 0x11 = 豎分割线
Create_framegui_like_Edit("xs+", 47, "y+", 15 , 239, 45,, 1)
back_Btn_Other_setting_apply_change := MainGui.Add("Text","xp+6 yp+3 w105 h39",)
Btn_Other_setting_apply_change := MainGui.Add("Button", "xp+2 yp+2 w101 h35", "套用設定")
MainGui.Add("Text", "0x11 x+10 yp+2 w1 h35")
Btn_Other_setting_cancel_change := MainGui.Add("Button","x+10 yp-2 w101 h35","取消變更")
MainGui.Add("Text", "xs+470 y+70", "由波菜菜菜免費`n分享於巴哈姆特").SetFont("cEAEAEA")

;-----Other_setting_part_OnEvent

DDL_reset_all_timer_HK1.OnEvent("change",start_check_is_no_same_hotkey)
DDL_reset_all_timer_HK1.OnEvent("change",Other_setting_unsafed_check)
DDL_hide_mainGUI_HK1.OnEvent("change",start_check_is_no_same_hotkey)
DDL_hide_mainGUI_HK1.OnEvent("change",Other_setting_unsafed_check)
DDL_reload_script_HK1.OnEvent("change",start_check_is_no_same_hotkey)
DDL_reload_script_HK1.OnEvent("change",Other_setting_unsafed_check)
Bool_CD_resettable_Trig1.OnEvent("click",Other_setting_unsafed_check)
Bool_enable_when_winactive_Trig1.OnEvent("click",Other_setting_unsafed_check)
str_winactive_name1.OnEvent("change",Other_setting_unsafed_check)
Btn_Other_setting_apply_change.OnEvent("click",Other_setting_apply_change)
Btn_Other_setting_cancel_change.OnEvent("click",Other_setting_cancel_change)

Tab_main_tabs.UseTab()

;/*開發工具
; MainGui.Add("Button", "xm+100 ym+0 w60 h30", "ReLV").OnEvent("Click", (*) => check_buff_settings_format("buff_settings_1"))
; MainGui.Add("Button", "xm+450 ym+0 w90 h30", "data_arr").OnEvent("Click",show_data_arry)
; MainGui.Add("Button", "x+0 ym+0 w90 h30", "arr1").OnEvent("Click",show_data_arry_2)

MainGui.Add("Text", "xm+15 ym+40","當前設定檔：")
Create_framegui_like_Edit("x+", 3, "ym+", 36 ,330, 34)
Num_now_buff_settting_num := MainGui.Add("text", "xp+8 yp+4 w33 h30 BackgroundTrans ","0")
MainGui.Add("Text", "xp+15 yp BackgroundTrans","：")
text_now_buff_settting_name := MainGui.Add("text", "x+3 yp w260 h30 BackgroundTrans ","buff_setting_0")

btn_quick_reset_all_timer := MainGui.Add("Button","xm+440 ym-7 w90 h30","重置計時")
btn_quick_reset_all_timer.OnEvent("Click",stop_all_countdown_for_SL)
btn_quick_hide_Fwin := MainGui.Add("Button","xm+530 ym-7 w95 h30","隱藏浮窗")
btn_quick_show_Fwin := MainGui.Add("Button","xm+530 ym-7 w95 h30","顯示浮窗")
btn_quick_hide_Fwin.OnEvent("Click",Fwin_quick_show_Switch)
btn_quick_show_Fwin.OnEvent("Click",Fwin_quick_show_Switch)
btn_quick_hide_Fwin.Visible := false

;-----MainGui_OnEvent
Bool_FWin_SW1.OnEvent("Click",Fwin_show_Switch)
MainGui.OnEvent("Close", (*) => ExitApp())
objects_disabled_state_switch(0)
MainGui.show("w" 653 " h" 568)
;MainGui.Show("AutoSize")
;WinGetPos(,, &MainGui_W,&MainGui_H, "ahk_id " MainGui.Hwnd)
;MainGui.move(,,MainGui_W-14,MainGui_H-5)

;-----TrayMenu_part
/*
A_TrayMenu.Insert("1&", "") 
arr_TrayMenu_objects.push("line") 
A_TrayMenu.Insert("2&","隱藏設定視窗", (*) => TrayMenu_enable_SL_slot(count_x))
arr_TrayMenu_objects.push("隱藏設定視窗") 
A_TrayMenu.Insert("3&", "")  
arr_TrayMenu_objects.push("line") 
A_TrayMenu.Insert("4&","隱藏懸浮視窗", (*) => TrayMenu_enable_SL_slot(count_x))
arr_TrayMenu_objects.push("隱藏懸浮視窗") 
A_TrayMenu.Insert("5&", "")  
arr_TrayMenu_objects.push("line") 

Loop 8
{
    count_x := A_Index
    A_TrayMenu.Insert(count_x+5 "&"," 應用slot " count_x, (*) => TrayMenu_enable_SL_slot(count_x))
}
A_TrayMenu.Insert("14&", "")  

; A_TrayMenu.Check(currentNum)
; ===== 函式 =====
TrayMenu_enable_SL_slot(slot_num)
{
    ; 先取消全部勾選
    Loop 8
        A_TrayMenu.Uncheck(A_Index)
    ; 勾選目前數字
    A_TrayMenu.Check("應用slot " slot_num)
}
*/


; ~-::MainGui.Show("AutoSize")
; ~=::MainGui.move(640,320)

;-----FWinGui_base_Construct-----
FWinGui_base := Gui("+LastFound +AlwaysOnTop +ToolWindow +E0x8000000 -Resize -Caption", 'MS_Buff_Floating_Window')
FWinGui_base.SetFont("s12 c000000 w700 Q3","Arial")
FWinGui_base.BackColor := "EEEEEE"
WinSetTransColor(FWinGui_base.BackColor, FWinGui_base.hwnd)
try {
    pic_move_arrow := FWinGui_base.Add("Picture", "vpic_move_arrow xm-15 ym-7 w32 h32 BackGroundTrans", A_ScriptDir "\buff_pngs\arrow.png") ; +Border")
}
catch {
    pic_move_arrow := FWinGui_base.Add("text", "vpic_move_arrow xm-15 ym-7 w25 h25 BackGroundF0F0F0 +Border")
}
FWinGui_base.Show("w450 h150")
Fwin_show_state := 1
;-----FWinGui_layer1_Construct-----
;WS_EX_NOACTIVATE style:+E0x8000000選項讓GUI被點擊也不被認為active視窗
FWinGui_layer1 := Gui("+LastFound +ToolWindow +E0x8000000 -Resize -Caption")
FWinGui_layer1.opt("+Parent" FWinGui_base.hwnd)
FWinGui_layer1.SetFont("s12 c000000 w700 Q3","Arial")
FWinGui_layer1.BackColor := "EEEEEE"
WinSetTransColor(FWinGui_layer1.BackColor, FWinGui_layer1.hwnd)
Pic_tab1_slot1 :=FWinGui_layer1.Add("Picture", "vPic_tab1_slot1 xm+10 ym+18 w40 h40 BackGroundTrans ") ; +Border")
Pic_tab1_slot2 :=FWinGui_layer1.Add("Picture", "vPic_tab1_slot2 x+0 yp+0 w40 h40 BackGroundTrans") ; +Border")
Pic_tab1_slot3 :=FWinGui_layer1.Add("Picture", "vPic_tab1_slot3 x+0 yp+0 w40 h40 BackGroundTrans") ; +Border")
Pic_tab1_slot4 :=FWinGui_layer1.Add("Picture", "vPic_tab1_slot4 x+0 yp+0 w40 h40 BackGroundTrans") ; +Border")
Pic_tab1_slot5 :=FWinGui_layer1.Add("Picture", "vPic_tab1_slot5 x+0 yp+0 w40 h40 BackGroundTrans") ; +Border")
Pic_tab1_slot6 :=FWinGui_layer1.Add("Picture", "vPic_tab1_slot6 x+0 yp+0 w40 h40 BackGroundTrans") ; +Border")
Pic_tab1_slot7 :=FWinGui_layer1.Add("Picture", "vPic_tab1_slot7 x+0 yp+0 w40 h40 BackGroundTrans") ; +Border")
Pic_tab1_slot8 :=FWinGui_layer1.Add("Picture", "vPic_tab1_slot8 x+0 yp+0 w40 h40 BackGroundTrans") ; +Border")
Pic_tab1_slot9 :=FWinGui_layer1.Add("Picture", "vPic_tab1_slot9 x+0 yp+0 w40 h40 BackGroundTrans") ; +Border")
Pic_tab1_slot10 :=FWinGui_layer1.Add("Picture", "vPic_tab1_slot10 x+0 yp+0 w40 h40 BackGroundTrans") ; +Border")
arrobj_all_Pic_tab1_slot := [ 
    Pic_tab1_slot1, Pic_tab1_slot2, Pic_tab1_slot3, Pic_tab1_slot4, Pic_tab1_slot5,
    Pic_tab1_slot6, Pic_tab1_slot7, Pic_tab1_slot8, Pic_tab1_slot9, Pic_tab1_slot10
]
;back_time_tab1_slot1 := FWinGui_layer1.Add("Text","xm+8 ym+0 w40 h19 BackgroundFFFFFF","") ;設定文字背景顏色
;back_time_tab1_slot1.move(,,30)
FWinGui_layer1.Show("x0 y0")
Pic_tab1_slot1.OnEvent("DoubleClick",DoubleClick_pic_trun_on_timer)

;-----FWinGui_layer2_Construct-----
FWinGui_layer2 := Gui("+LastFound +ToolWindow +E0x8000000 -Resize -Caption")
FWinGui_layer2.opt("+Parent" FWinGui_base.hwnd)
FWinGui_layer2.SetFont("s12 c000000 w700 Q3","Arial")
FWinGui_layer2.BackColor := "EEEEEE"
WinSetTransColor(FWinGui_layer2.BackColor, FWinGui_layer2.hwnd)
;PROG_tab1_slot1 := FWinGui_layer2.Add("Progress", "vPROG_tab1_slot1 xm+10 ym+20 w40 h40 c000000 Range0-10 +Vertical BackgroundEEEEEE", 10)
    ;for_test
    ; Pic_child_tab1_slot1 :=FWinGui_layer2.Add("Picture", "vPic_child_tab1_slot1 xm+11 ym+19 w38 h38 BackGroundTrans") ; +Border")
    ;Pic_child_tab1_slot1 :=FWinGui_layer2.Add("Picture", "vPic_child_tab1_slot1 xm+10 ym+20 w40 h40 BackGroundTrans") ; +Border")
    ; Pic_child_tab1_slot1.Value := A_ScriptDir "\buff_pngs\gray\transformation.png"
    ;Pic_child_tab1_slot1.hide()
Pic_child_tab1_slot1 :=FWinGui_layer2.Add("Picture", "vPic_child_tab1_slot1 xm+11 ym+19 w38 h38 BackGroundTrans") ; +Border")
Pic_child_tab1_slot2 :=FWinGui_layer2.Add("Picture", "vPic_child_tab1_slot2 x+2 yp+0 w38 h38 BackGroundTrans") ; +Border")
Pic_child_tab1_slot3 :=FWinGui_layer2.Add("Picture", "vPic_child_tab1_slot3 x+2 yp+0 w38 h38 BackGroundTrans") ; +Border")
Pic_child_tab1_slot4 :=FWinGui_layer2.Add("Picture", "vPic_child_tab1_slot4 x+2 yp+0 w38 h38 BackGroundTrans") ; +Border")
Pic_child_tab1_slot5 :=FWinGui_layer2.Add("Picture", "vPic_child_tab1_slot5 x+2 yp+0 w38 h38 BackGroundTrans") ; +Border")
Pic_child_tab1_slot6 :=FWinGui_layer2.Add("Picture", "vPic_child_tab1_slot6 x+2 yp+0 w38 h38 BackGroundTrans") ; +Border")
Pic_child_tab1_slot7 :=FWinGui_layer2.Add("Picture", "vPic_child_tab1_slot7 x+2 yp+0 w38 h38 BackGroundTrans") ; +Border")
Pic_child_tab1_slot8 :=FWinGui_layer2.Add("Picture", "vPic_child_tab1_slot8 x+2 yp+0 w38 h38 BackGroundTrans") ; +Border")
Pic_child_tab1_slot9 :=FWinGui_layer2.Add("Picture", "vPic_child_tab1_slot9 x+2 yp+0 w38 h38 BackGroundTrans") ; +Border")
Pic_child_tab1_slot10 :=FWinGui_layer2.Add("Picture", "vPic_child_tab1_slot10 x+2 yp+0 w40 h40 BackGroundTrans") ; +Border")
arrobj_all_Pic_child_tab1_slot := [ 
    Pic_child_tab1_slot1, Pic_child_tab1_slot2, Pic_child_tab1_slot3, Pic_child_tab1_slot4, Pic_child_tab1_slot5,
    Pic_child_tab1_slot6, Pic_child_tab1_slot7, Pic_child_tab1_slot8, Pic_child_tab1_slot9, Pic_child_tab1_slot10
]
Pic_child_tab1_drag_targets :=[
    Pic_child_tab1_slot1.Hwnd, Pic_child_tab1_slot2.Hwnd, Pic_child_tab1_slot3.Hwnd, Pic_child_tab1_slot4.Hwnd, Pic_child_tab1_slot5.Hwnd,
    Pic_child_tab1_slot6.Hwnd, Pic_child_tab1_slot7.Hwnd, Pic_child_tab1_slot8.Hwnd, Pic_child_tab1_slot9.Hwnd, Pic_child_tab1_slot10.Hwnd
]
;將layer2圖片的預設為不可見
loop (arrobj_all_Pic_child_tab1_slot.Length) {
    Pic_slot_visibility_SW(A_Index, 1)
    ;arrobj_all_Pic_child_tab1_slot[A_Index].Visible := false ;設定黑白layer2不可見
}

Pic_child_tab1_slot1.OnEvent("DoubleClick",DoubleClick_pic_trun_on_timer)
FWinGui_layer2.Show("x0 y0")

DoubleClick_pic_trun_on_timer(*) {
    msgbox "yes"
}

;WinSetTransparent(0, FWinGui_layer2)

;-----FWinGui_layer3_Construct-----
FWinGui_layer3 := Gui("+LastFound +ToolWindow +E0x8000000 -Resize -Caption")
FWinGui_layer3.opt("+Parent" FWinGui_base.hwnd)
FWinGui_layer3.SetFont("s12 c000000 w700 Q3","Arial")
FWinGui_layer3.BackColor := "EEEEEE"
WinSetTransColor(FWinGui_layer3.BackColor, FWinGui_layer3.hwnd)

back_time_tab1_slot1 := FWinGui_layer3.Add("Text","xm+9 ym-2 w30 h18 BackgroundcF0F0F0") ;4位數字w40
back_time_tab1_slot2 := FWinGui_layer3.Add("Text","xp+40 yp+0 w30 h18 BackgroundcF0F0F0")
back_time_tab1_slot3 := FWinGui_layer3.Add("Text","xp+40 yp+0 w30 h18 BackgroundcF0F0F0")
back_time_tab1_slot4 := FWinGui_layer3.Add("Text","xp+40 yp+0 w30 h18 BackgroundcF0F0F0")
back_time_tab1_slot5 := FWinGui_layer3.Add("Text","xp+40 yp+0 w30 h18 BackgroundcF0F0F0")
back_time_tab1_slot6 := FWinGui_layer3.Add("Text","xp+40 yp+0 w30 h18 BackgroundcF0F0F0")
back_time_tab1_slot7 := FWinGui_layer3.Add("Text","xp+40 yp+0 w30 h18 BackgroundcF0F0F0")
back_time_tab1_slot8 := FWinGui_layer3.Add("Text","xp+40 yp+0 w30 h18 BackgroundcF0F0F0")
back_time_tab1_slot9 := FWinGui_layer3.Add("Text","xp+40 yp+0 w30 h18 BackgroundcF0F0F0")
back_time_tab1_slot10 := FWinGui_layer3.Add("Text","xp+40 yp+0 w30 h18 BackgroundcF0F0F0")
arrobj_all_back_time_tab1_slot := [ 
    back_time_tab1_slot1, back_time_tab1_slot2, back_time_tab1_slot3, back_time_tab1_slot4, back_time_tab1_slot5,
    back_time_tab1_slot6, back_time_tab1_slot7, back_time_tab1_slot8, back_time_tab1_slot9, back_time_tab1_slot10
]
;將layer3的back_timers預設為不可見
loop (arrobj_all_back_time_tab1_slot.Length) {
    arrobj_all_back_time_tab1_slot[A_Index].Visible := false ;設定timer不可見
}
Num_time_tab1_slot1 := FWinGui_layer3.Add("Text","xm+10 ym-2 w100 E0x20 +BackgroundTrans","111") ;4位數字w40
Num_time_tab1_slot2 := FWinGui_layer3.Add("Text","xp+40 yp+0 w100 E0x20 +BackgroundTrans","222")
Num_time_tab1_slot3 := FWinGui_layer3.Add("Text","xp+40 yp+0 w100 E0x20 +BackgroundTrans","333")
Num_time_tab1_slot4 := FWinGui_layer3.Add("Text","xp+40 yp+0 w100 E0x20 +BackgroundTrans","444")
Num_time_tab1_slot5 := FWinGui_layer3.Add("Text","xp+40 yp+0 w100 E0x20 +BackgroundTrans","555")
Num_time_tab1_slot6 := FWinGui_layer3.Add("Text","xp+40 yp+0 w100 E0x20 +BackgroundTrans","666")
Num_time_tab1_slot7 := FWinGui_layer3.Add("Text","xp+40 yp+0 w100 E0x20 +BackgroundTrans","777")
Num_time_tab1_slot8 := FWinGui_layer3.Add("Text","xp+40 yp+0 w100 E0x20 +BackgroundTrans","888")
Num_time_tab1_slot9 := FWinGui_layer3.Add("Text","xp+40 yp+0 w100 E0x20 +BackgroundTrans","999")
Num_time_tab1_slot10 := FWinGui_layer3.Add("Text","xp+40 yp+0 w100 E0x20 +BackgroundTrans","000")
arrobj_all_time_tab1_slot := [ 
    Num_time_tab1_slot1, Num_time_tab1_slot2, Num_time_tab1_slot3, Num_time_tab1_slot4, Num_time_tab1_slot5,
    Num_time_tab1_slot6, Num_time_tab1_slot7, Num_time_tab1_slot8, Num_time_tab1_slot9, Num_time_tab1_slot10
]
;將layer3的timers預設為不可見 
loop (arrobj_all_time_tab1_slot.Length) {
    arrobj_all_time_tab1_slot[A_Index].Visible := false ;設定timer不可見
}
FWinGui_layer3.Show("x0 y0")

;~~~~~視窗移動函式
OnMessage(0x201, WM_Letguidraggable) ;訊息WM_LBUTTONDOWN := 0x201, 
OnMessage(0x232, WM_getguimoved) ;訊息WM_EXITSIZEMOVE := 0x232

;~~~~~設定檔SL
;try FileDelete A_ScriptDir "\setting_files\" "General_Settings" ".ini"
;try FileDelete A_ScriptDir "\setting_files\" "buff_settings_1" ".ini"
Create_Settings_Folder("setting_files")
Create_Settings_Folder("buff_pngs")
Create_Settings_Folder("buff_pngs\" sub_pic_folder_name)
Create_Settings_Folder("SE_wavs")
Create_General_Settings_file("General_Settings")
loop (arr_ALL_Classes_pic_folder.Length) {
    Create_Settings_Folder("buff_pngs\" arr_ALL_Classes_pic_folder[A_Index])
    Create_Settings_Folder("buff_pngs\" arr_ALL_Classes_pic_folder[A_Index] "\" sub_pic_folder_name)
}
Create_buff_settings_file("buff_settings_1")
load_General_Settings_setting_file("General_Settings")
enable_last_closed_Setting()
;load_buff_settings_file("buff_settings_1",)
;~~~~~


    ;fortest
    ;rrobj_all_Pic_tab1_slot[1].GetPos(&posed_pic_x1,&posed_pic_y1 ) ;取得圖片一的xy座標
    ;arrobj_all_time_tab1_slot[1].GetPos(&posed_time_x1, &posed_time_y1, , )
    ;msgbox "X:" posed_pic_x1 " Y:" posed_pic_y1 "`nX:" posed_time_x1 " Y:" posed_time_y1


global_variables_setting()
{ 
global count_x := 0, count_y := 0
global MainGui_show_state := 1, Fwin_show_state := 0, sub_pic_folder_name := "Gray"
global Selecting_LV_RowNum := 0, Num_Selecting_SL_slot := 1
global countdown_timer_is_running := 0, arr_tab1_last_showtime := Array(0,0,0,0,0,0,0,0,0,0), color_Fwin_time := "000000"
global num_countdown_timer_interval := 500, float_countdown_step := num_countdown_timer_interval/1000
global SE_sound_is_playing := 0, SE_sound_is_playing_wav := 0, scrip_start_setting := 1, arr_selected_wav_file_path := Array("","") 
global arr_temp_1 := Array(""), arr_temp_2 := Array("") 
global saved_settting_enable_green_frame_state := Array(0,0,0,0,0,0,0,0)
global buff_red_frame_state := 0, buff_green_frame_state := 0
global FWin_red_frame_state := 0, FWin_green_frame_state := 0
global Other_setting_red_frame_state := 0, Other_setting_green_frame_state := 0
global arr_TrayMenu_objects := Array()
global arr_newdata_set := Array("技能名稱","non","0","0","non","0","0","0","0","0","0")
global arr_newbuff_name_Col := Array("技能1","技能2","技能3","技能4","技能5","技能6","技能7","技能8","技能9","技能10")
;1-5>"名稱","按鍵","持續時間","冷卻時間","圖片位址",
;6-11>"end_SE_type","end_SE_pitch","end_AI_sec","CD_SE_type","CD_SE_pitch","CD_AI_sec"
global arr2d_tab1_AllLV_data := [
    ["飄雪結晶","non","600","0",A_ScriptDir "\buff_pngs\Snowflakes.png","5","6","10","0","0","0"],
    ["","","","","","","","","","",""],
    ["","","","","","","","","","",""],
    ["","","","","","","","","","",""],
    ["","","","","","","","","","",""],
    ["","","","","","","","","","",""],
    ["","","","","","","","","","",""],
    ["","","","","","","","","","",""],
    ["","","","","","","","","","",""],
    ["","","","","","","","","","",""]
]
global test_arr2d_tab1_AllLV_data := [
    ["飄雪結晶","6","12","0",A_ScriptDir "\buff_pngs\Snowflakes.png","0","0","0","0","0","0"],
    ["鬥神附體","PgUp","240","360",A_ScriptDir "\buff_pngs\transformation.png","5","6","7","7","5","0"],
    ["魔力再生","PgDn","0","25",A_ScriptDir "\buff_pngs\mpRecovery.png","0","0","0","0","0","0"],
    ["","","","","","","","","","",""],
    ["","","","","","","","","","",""],
    ["","","","","","","","","","",""],
    ["","","","","","","","","","",""],
    ["","","","","","","","","","",""],
    ["","","","","","","","","","",""],
    ["","","","","","","","","","",""]
]
;1-6>"啟用懸浮窗","鎖定懸浮窗","懸浮窗座標X","懸浮窗座標Y","圖示大小","圖示間距",
;7-10>"數字大小","數字位置","數字顏色","數字底色"
global arr_tab1_FWin_Setting_data := Array(1, 0, 640, 360, 40, 0, 12, 2,"Black","F0F0F0")
;"持續圖片透明度","結束圖片透明度","文字透明度","倒數顯示分鐘"
global arr_tab1_FWin_Setting_2_data := Array(255, 255, 255, 600,"","","","","","")
;"重置timer熱鍵","隱藏視窗熱鍵","重啟程式熱鍵","只在活動視窗啟動","活動視窗名稱","冷卻按鍵無效"
global arr_tab1_Other_Setting_data := Array("non", "non", "non", 1, "MapleStory Worlds-Artale (繁體中文版)","0","","","","","")
;紀錄"上次關閉啟用的設定檔","上次關閉x值","上次關閉y值"
global arr_tab1_last_closed_Setting := Array("1","640","360")
;"設定檔1路徑","設定檔2","設定檔3","設定檔4","設定檔5","設定檔6","設定檔7","設定檔8"
global arr_tab1_each_buff_setting_path := Array(A_ScriptDir "\setting_files\buff_settings_1.ini",A_ScriptDir "\setting_files\buff_settings_2.ini","","","","","","","","")
global arr_tab1_timer_state := Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
global arr_tab1_timer_nowtime := Array(0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
global arr_AllKBKeys := Array(
    "non","A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
    "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
    "1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
    ",",".","/",";","'","[","]","-","=","\","~",
    "Shift", "Control", "Alt", "Space", 
    "LButton", "RButton", "MButton", "XButton1", "XButton2", 
    "Tab", "Backspace", "Delete", "Insert","Home", "End", "PgUp", "PgDn", 
    "Up", "Down", "Left", "Right",
    "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12",
    "Numpad0", "Numpad1", "Numpad2", "Numpad3", "Numpad4", "Numpad5", "Numpad6", "Numpad7", "Numpad8", "Numpad9",
    "NumpadDot", "NumpadDiv", "NumpadMult", "NumpadAdd", "NumpadSub",
    "PrintScreen", "ScrollLock", "Pause"
)
global arr_SE_types :=  Array(
"SE_off","1beep","2beep","2b_rise","2b_fall","3beep","3b_rise","3b_fall","1midi","2midi","2m_rise","2m_fall","3midi","3m_rise","3m_fall","自訂wav"
)
global arr_pitch_names :=  Array(
"Do(C3)", "Re(D3)",	"Mi(E3)", "Fa(F3)", "So(G3)", "La(A3)",	"Si(B3)", "Do(C4)"
)
global arr_pitch_A3_to_E5 := Array(
    0, 220, 246.93, 261.63, 293.66, 329.62, 349.23, 392, 440, 493.87, 523.25, 587.33, 659.25
)
global arr_pitch_wav_files := Array(
    0, 
    A_ScriptDir "\SE_wavs\pitch_A2.wav",
    A_ScriptDir "\SE_wavs\pitch_B2.wav",
    A_ScriptDir "\SE_wavs\pitch_C3.wav",
    A_ScriptDir "\SE_wavs\pitch_D3.wav",
    A_ScriptDir "\SE_wavs\pitch_E3.wav",
    A_ScriptDir "\SE_wavs\pitch_F3.wav",
    A_ScriptDir "\SE_wavs\pitch_G3.wav",
    A_ScriptDir "\SE_wavs\pitch_A3.wav",
    A_ScriptDir "\SE_wavs\pitch_B3.wav",
    A_ScriptDir "\SE_wavs\pitch_C4.wav",
    A_ScriptDir "\SE_wavs\pitch_D4.wav",
    A_ScriptDir "\SE_wavs\pitch_E4.wav"
)
global arr_SE_ready_to_play := Array(), arr_SE_ready_to_play_wav := Array() 
global arr_ALL_Classes := Array(
    "共通", "劍士", "法師", "弓箭手", "盜賊", "海盜", "其他"
)
global arr_ALL_Classes_pic_folder := Array(
    "Common", "Warrior", "Magician", 
    "Bowman", "Thief", "Pirate", "Others"
)
global arr_ALL_Classes_array := Array(
    "arr2d_ALLbuff_Common", "arr2d_ALLbuff_Warrior", "arr2d_ALLbuff_Magician", 
    "arr2d_ALLbuff_Bowman", "arr2d_ALLbuff_Thief", "arr2d_ALLbuff_Pirate", "arr2d_ALLbuff_Others"
)
;["技能名","持續時間","冷卻時間","圖片名稱"]
global arr2d_ALLbuff_Common := Array(
    ["楓葉祝褔", "270", "0", "mapleWarrior"],
    ["楓葉淨化", "0", "600", "heroesWill"],
    ["經驗加倍", "1800", "0", "DoubleEXP"],
    ["掉落加倍", "1800", "0", "DoubleDrap"],
    ["飄雪結晶", "600", "0", "Snowflakes"],
    ["漫天花雨", "600", "0", "Flowerrain"],
    ["buff藥水", "180", "0", "buffpotion"],
    ["buff藥丸", "600", "0", "buffpill"],
    ["龍寶寶副食品", "1200", "0", "BabyDragonFood"],
    ["加量章魚燒", "600", "0", "TakoyakiJumbo"],
    ["雙份日式炒麵", "600", "0", "Yakisobax2"],
    ["疼痛舒緩劑", "1800", "0", "painreliever"],
    ["氣泡", "900", "0", "airbubble"]
)
global arr2d_ALLbuff_Warrior := Array(
    ["自身強化", "300", "0", "ironBody"],
    ["快速之劍", "300", "0", "swordBooster"],
    ["快速之斧", "300", "0", "axeBooster"],
    ["快速之棍", "300", "0", "bluntWeaponBooster"],
    ["快速之槍", "300", "0", "spearBooster"],
    ["快速之矛", "300", "0", "polearmBooster"],
    ["反射之盾", "300", "0", "powerGuard"],
    ["激勵", "300", "0", "fury"],
    ["神聖之火", "300", "0", "hyperBody"],
    ["禦魔陣", "300", "0", "ironWall"],
    ["降魔咒", "45", "0", "threaten"],
    ["鬥氣集中", "200", "0", "comboAttack"],
    ["防禦消除", "300", "0", "armorCrash"],
    ["力量消除", "300", "0", "powerCrash"],
    ["龍之魂", "160", "0", "dragonBlood"],
    ["魔防消除", "300", "0", "magicCrash"],
    ["烈焰之劍", "300", "0", "flameChargeSword"],
    ["烈焰之棍", "300", "0", "flameChargeBluntWeapon"],
    ["寒冰之劍", "300", "0", "iceChargeSword"],
    ["寒冰之棍", "300", "0", "iceChargeBluntWeapon"],
    ["雷鳴之劍", "300", "0", "thunderChargeSword"],
    ["雷鳴之棍", "300", "0", "thunderChargeBluntWeapon"],
    ["格擋", "300", "0", "powerStance"],
    ["鬥氣爆發", "240", "480", "enrage"],
    ["暗之靈魂", "1200", "0", "beholder"],
    ["聖靈之劍", "300", "0", "holyChargeSword"],
    ["聖靈之棍", "300", "0", "holyChargeBlunt"],
    ["鬼神之擊", "0", "30", "heavensHammer"]
)
global arr2d_ALLbuff_Magician := Array(
    ["魔心防禦", "360", "0", "magicGuard"],
    ["魔力之盾", "300", "0", "magicArmor"],
    ["精神強化", "300", "0", "meditation"],
    ["緩速術", "40", "0", "slow"],
    ["魔力激發", "300", "0", "elementAmplification"],
    ["極速詠唱", "120", "0", "spellBooster"],
    ["魔法封印", "18", "0", "seal"],
    ["神聖之光", "300", "0", "invincible"],
    ["天使祝福", "300", "0", "bless"],
    ["神聖祈禱", "300", "0", "holySymbol"],
    ["時空門", "30", "0", "mysticDoor"],
    ["聖龍召喚", "300", "0", "summonDragon"],
    ["喚化術", "20", "0", "Doom"],
    ["魔力無限", "11", "600", "infinity"],
    ["魔法反射", "250", "0", "manaReflection"],
    ["寒冰地獄", "15", "0", "iceDemon"],
    ["召喚火炎神", "110", "0", "ifrit"],
    ["炎靈地獄", "15", "0", "fireDemon"],
    ["召喚冰魔", "110", "0", "elquines"],
    ["復甦之光", "0", "3420", "resurrection"],
    ["召喚神龍", "160", "0", "bahamut"],
    ["聖盾護鎧", "11", "120", "holyShield"]
)
global arr2d_ALLbuff_Bowman := Array(
    ["集中術", "300", "0", "focus"],
    ["快速之箭", "300", "0", "bowBooster"],
    ["快速之弩", "300", "0", "crossbowBooster"],
    ["無形之箭", "300", "0", "soulArrow"],
    ["替身術", "60", "0", "puppet"],
    ["銀鷹召喚", "175", "0", "silverHawk"],
    ["金鷹召喚", "175", "0", "goldenEagle"],
    ["會心之眼", "300", "0", "sharpEyes"],
    ["念力集中", "180", "360", "concentrate"],
    ["召喚鳳凰", "200", "0", "phoenix"],
    ["召喚銀隼", "200", "0", "frostprey"]
)
global arr2d_ALLbuff_Thief := Array(
    ["詛咒術", "45", "0", "disorder"],
    ["隱身術", "10", "0", "darkSight"],
    ["速度激發", "300", "0", "haste"],
    ["極速暗殺", "300", "0", "clawBooster"],
    ["幸運術", "300", "0", "mesoUP"],
    ["影分身", "300", "0", "shadowPartner"],
    ["快速之刀", "300", "0", "daggerBooster"],
    ["勇者掠奪術", "180", "0", "pickpocket"],
    ["楓幣護盾", "120", "0", "mesoGuard"],
    ["血魔轉換", "0", "210", "chakra"],
    ["無形鏢", "120", "0", "shadowStars"],
    ["煙霧彈", "31", "600", "smokescreen"]
)
global arr2d_ALLbuff_Pirate := Array(
    ["衝鋒", "150", "0", "dash"],
    ["迅雷再起", "300", "0", "gunBooster"],
    ["炸彈投擲", "10", "0", "grenade"],
    ["章魚砲台", "0", "10", "octopus"], 
    ["指定攻擊", "20", "0", "homingBeacon"],
    ["海鷗突擊隊", "0", "5", "gaviota"],
    ["砲台章魚王", "0", "10", "wrathoftheOctopi"], 
    ["海盜船", "0", "60", "battleship"],
    ["心靈控制", "40", "0", "hypnotize"],
    ["精準砲擊", "50", "0", "bullseye"],
    ["海鷗特戰隊", "0", "5", "airStrike"], 
    ["致命快打", "150", "300", "knuckleBooster"],
    ["魔力再生", "0", "25", "mpRecovery"],
    ["偽裝術", "0", "20", "oakBarrel"],
    ["鬥神附體", "240", "360", "transformation"],
    ["最終極速", "210", "0", "speedInfusion"],
    ["時間置換", "0", "3540", "timeLeap"],
    ["鬥神降世", "240", "240", "superTransformation"] 
)
global arr2d_ALLbuff_Others := Array(
    ["經驗獲取", "300", "0", "EXP_pic"],
    ["1分鐘", "60", "0", "1min"],
    ["1.5分鐘", "90", "0", "1.5min"],
    ["2分鐘", "120", "0", "2min"],
    ["3.5分鐘", "210", "600", "3.5min"],
    ["5分鐘", "300", "0", "5min"],
    ["8分鐘", "480", "0", "8min"],
    ["10分鐘", "600", "0", "10min"],
    ["15分鐘", "900", "0", "15min"],
    ["20分鐘", "1200", "0", "20min"],
    ["30分鐘", "1800", "0", "30min"],
    ["60分鐘", "3600", "0", "60min"]
)
}

trun_array_into_single_Str(arr_x) {
    ;將一個一維矩陣轉換成 "arr[1], arr[2], ~" 的單一字串
    local str_temp_1 := ""
    if (Type(arr_x) == "Array") {
        for , value in arr_x { ; 遍歷arr_x的值
            if (A_Index != 1) {
                str_temp_1 .= "`` " ; .= 在字串後方加入"` "
            }
            str_temp_1 .= value 
        }
    }
    else if (Type(arr_x) == "String") {
        return arr_x
    }
    return str_temp_1
}

Var_Type_confirm(var) {
    var := Trim(var)
    if RegExMatch(var, "^-?\d+(\.\d+)?$")  ; 整數或浮點數
        return var + 0  ; 轉成數字
    return var          ; 保留文字
}

save_into_ini(arr_x, arr_x_name, dimension, file_name := "", file_Path := "") {
    chose_file_name_or_file_path(&file_name,&file_Path)
    ;local file_Path := A_ScriptDir "\setting_files\" file_name ".ini"
    if (dimension == 1) {
    IniWrite(trun_array_into_single_Str(arr_x), file_Path, arr_x_name, "row1")
    }
    else if (dimension == 2) {
        for , row in arr_x { ; 遍歷arr2d的row
            IniWrite(trun_array_into_single_Str(row), file_Path, arr_x_name, "row" A_Index )
        }
    }
}

load_from_ini(arr_x_name, dimension, file_name := "", file_Path := "") {
    chose_file_name_or_file_path(&file_name,&file_Path)
    arr_temp_x := []
    if (dimension == 1) {
        local str_temp_1 := Iniread(file_Path, arr_x_name, "row1", "")
        for , value in StrSplit(str_temp_1, "``") {
            arr_temp_x.Push(Var_Type_confirm(value))
        }
    }
    else if (dimension == 2 and arr_x_name == "arr2d_tab1_AllLV_data") {
        local num_line_count := StrSplit(Iniread(file_Path, arr_x_name, , ""), "`n").Length ;計算二維矩陣資料的行數
        loop (num_line_count) {
            local str_temp_1 := IniRead(file_Path, arr_x_name, "row" A_Index, "EOF") ;"EOF" := End of file
            if (str_temp_1 = "EOF") {
                break
            }
            local arr_temp_1 := []
            for , value in StrSplit(str_temp_1, "``") {
                arr_temp_1.Push( (A_Index != 2) ? Var_Type_confirm(value) : Trim(value))
            }
            arr_temp_x.Push(arr_temp_1)
        }
    }
    else if (dimension == 2) {
        local num_line_count := StrSplit(Iniread(file_Path, arr_x_name, , ""), "`n").Length ;計算二維矩陣資料的行數
        loop (num_line_count) {
            local str_temp_1 := IniRead(file_Path, arr_x_name, "row" A_Index, "EOF") ;"EOF" := End of file
            if (str_temp_1 = "EOF") {
                break
            }
            local arr_temp_1 := []
            for , value in StrSplit(str_temp_1, "``") {
                arr_temp_1.Push(Var_Type_confirm(value))
            }
            arr_temp_x.Push(arr_temp_1)
        }
    }
    return arr_temp_x
}

Create_framegui_like_Edit(x_opt := "x+", x_val := 0, y_opt := "y+", y_val := 0, w_val := 1, h_val := 1, &obj_array_name := "", Outline := 0) {
    if (Outline != 0) {
        MainGui.Add("text",x_opt x_val " " y_opt y_val " w" w_val + 6 " h" h_val + 6 " BackgroundD0D0D0")
        ; MainGui.Add("text", "xp+2 yp+2 w" w_val + 2 " h" h_val + 3 " BackgroundA0A0A0")
        MainGui.Add("text", "xp+1 yp+1 w" w_val + 4 " h" h_val + 4 " BackgroundE0E0E0")
    }
    else {
        MainGui.Add("text", x_opt x_val " " y_opt y_val " w" w_val + 2 " h" h_val + 3 " BackgroundA0A0A0")
        MainGui.Add("text", "xp-1 yp-1 w" w_val + 4 " h" h_val + 3 " BackgroundE0E0E0")
    }
    MainGui.Add("text", "xp+1 yp+1 w" w_val + 2 " h" h_val + 2 " BackgroundFEFEFE")
    if (obj_array_name == "") {
        MainGui.Add("text", "xp+1 yp+1  w" w_val " h" h_val " BackgroundF0F0F0")
    }
    else {
        obj_array_name.push(MainGui.Add("text", "xp+1 yp+1  w" w_val " h" h_val " BackgroundF0F0F0"))
    }
}

Show_ToolTip(text, x_val, y_val, boj_name := "") {
    if(boj_name != "") {
        try {
            boj_name.GetPos(&boj_x, &boj_y, &boj_w, &boj_h)
            ToolTip text , boj_x + boj_w - 10 + x_val, boj_y + boj_h - 2 + y_val
            SetTimer () => ToolTip(), -3000
            return
        }
        catch {
        }
    }
    ToolTip text , x_val, y_val
    SetTimer () => ToolTip(), -3000
    return
}

Create_Settings_Folder(Folder_name) {
    local file_Path := A_ScriptDir "\" Folder_name
    if !DirExist(file_Path) {
        DirCreate(file_Path)
        ; MsgBox "資料夾不存在，已建立：" A_ScriptDir "\setting_files"
    }
}

chose_file_name_or_file_path(&file_name, &file_Path) {
    global arr2d_tab1_AllLV_data, arr_tab1_FWin_Setting_data, arr_tab1_FWin_Setting_2_data, arr_tab1_Other_Setting_data
    if (file_Path != "") {
        SplitPath file_Path, , , , &file_name
    }
    else if (file_Path == "" and file_name != "") {
        file_Path := A_ScriptDir "\setting_files\" file_name ".ini"
    }
    else {
        msgbox "file_Path and file_name are empty"
    }
}

check_General_Settings_format(file_name := "", file_Path := "") {
    chose_file_name_or_file_path(&file_name,&file_Path)
}

Create_General_Settings_file(file_name) {
    local file_Path := A_ScriptDir "\setting_files\" file_name ".ini"
    if !FileExist(file_Path) {
        FileAppend("", file_Path)  ; 建立空檔
        FileAppend('`n; "上次關閉啟用的設定檔","上次關閉x值","上次關閉y值"', file_path)
        FileAppend('`n[arr_tab1_last_closed_Setting]`n', file_path)
        FileAppend('`n; "設定檔1路徑","設定檔2路徑","設定檔3路徑","設定檔4路徑","設定檔5路徑","設定檔6路徑","設定檔7路徑","設定檔8路徑"', file_path)
        FileAppend('`n[arr_tab1_each_buff_setting_path]`n', file_path)
        FileAppend('`n; 顯示在UI技能職業表下拉選單的職業類別名稱', file_path)
        FileAppend('`n[arr_ALL_Classes]`n', file_path)
        FileAppend('`n; 與arr_ALL_Classes對應的職業技能圖片資料夾名稱', file_path)
        FileAppend('`n[arr_ALL_Classes_pic_folder]`n', file_path)
        FileAppend('`n; 與arr_ALL_Classes對應的職業技能矩陣section名稱', file_path)
        FileAppend('`n[arr_ALL_Classes_array]`n', file_path)
        save_into_ini(arr_tab1_last_closed_Setting, "arr_tab1_last_closed_Setting", 1, file_name)
        save_into_ini(arr_tab1_each_buff_setting_path, "arr_tab1_each_buff_setting_path", 1, file_name)
        save_into_ini(arr_ALL_Classes, "arr_ALL_Classes", 1, file_name)
        save_into_ini(arr_ALL_Classes_pic_folder, "arr_ALL_Classes_pic_folder", 1, file_name)
        save_into_ini(arr_ALL_Classes_array, "arr_ALL_Classes_array", 1, file_name)
        for name in arr_ALL_Classes_array {
            if IsSet(%name%) {       ; 檢查變數是否存在
                ;arr_ALL_Classes_array[A_Index] := %name% ;創建時不改變arr_ALL_Classes_array裡的矩陣名為該矩陣
                arr2d_temp_1 := %name%        ; 動態取得矩陣
                FileAppend('`n; ' arr_ALL_Classes[A_Index] '職業技能矩陣', file_path)
                FileAppend('`n[' name ']`n', file_path)
                save_into_ini(arr2d_temp_1, name, 2, file_name)
            }  
        }
    }
}

file_path_be_moved_check(file_path, type) {
    if (file_path == "" or file_path == "non" ) {
        return file_path
    }
    SplitPath file_Path, &file_name_Ext, &file_dir, , &file_name
    if (type == "ini" or type == 1) {
        if (FileExist(A_ScriptDir "\setting_files\" file_name ".ini")) {
            return A_ScriptDir "\setting_files\" file_name ".ini"
        }
    }
    if (type == "pic" or type == 2) {
        ; 尋找在buff_pngs中的所有資料夾
        path_temp_1 := A_ScriptDir "\buff_pngs" 
        arr_pic_folder_names := []
        Loop Files path_temp_1 "\*", "D"  ; D = 只列資料夾
        {
            if (A_LoopFileName != sub_pic_folder_name) {
                arr_pic_folder_names.Push(A_LoopFileName)
            }
        }
        ;找到檔案時返回路徑
        if (FileExist(path_temp_1 "\" file_name_Ext)) {
            return path_temp_1 "\" file_name_Ext
        }
        loop (arr_pic_folder_names.Length) {
            if (FileExist(path_temp_1 "\" arr_pic_folder_names[A_Index] "\" file_name_Ext)) {
                return path_temp_1 "\" arr_pic_folder_names[A_Index] "\" file_name_Ext
            }
        }
    }
    if (type == "child_pic" or type == 3) {
        ; 尋找在buff_pngs中的所有資料夾
        path_temp_1 := A_ScriptDir "\buff_pngs" 
        arr_pic_folder_names := []
        Loop Files path_temp_1 "\*", "D"  ; D = 只列資料夾
        {
            if (A_LoopFileName != sub_pic_folder_name) {
                arr_pic_folder_names.Push(A_LoopFileName)
            }
        }
        ;找到檔案時返回路徑
        if (FileExist(path_temp_1 "\" sub_pic_folder_name "\" file_name_Ext)) {
            return path_temp_1 "\" sub_pic_folder_name "\" file_name_Ext
        }
        loop (arr_pic_folder_names.Length) {
            if (FileExist(path_temp_1 "\" arr_pic_folder_names[A_Index] "\" sub_pic_folder_name "\" file_name_Ext)) {
                return path_temp_1 "\" arr_pic_folder_names[A_Index] "\" sub_pic_folder_name "\" file_name_Ext
            }
        }
    }
    if (type == "wav" or type == 4) {
        ; 尋找在SE_wavs中的所有資料夾
        path_temp_1 := A_ScriptDir "\SE_wavs" 
        arr_pic_folder_names := []
        Loop Files path_temp_1 "\*", "D"  ; D = 只列資料夾
        {
            if (A_LoopFileName != sub_pic_folder_name) {
                arr_pic_folder_names.Push(A_LoopFileName)
            }
        }
        ;找到檔案時返回路徑
        if (FileExist(path_temp_1 "\" file_name_Ext)) {
            return path_temp_1 "\" file_name_Ext
        }
        loop (arr_pic_folder_names.Length) {
            if (FileExist(path_temp_1 "\" arr_pic_folder_names[A_Index] "\" file_name_Ext)) {
                return path_temp_1 "\" arr_pic_folder_names[A_Index] "\" file_name_Ext
            }
        }
    }
    if FileExist(file_path) {
        return file_path
    }
}

load_General_Settings_setting_file(file_name) {
    global arr_tab1_last_closed_Setting, arr_tab1_each_buff_setting_path, arr_ALL_Classes, arr_ALL_Classes_array, arr_ALL_Classes_array, Num_Selecting_SL_slot
    local file_Path := A_ScriptDir "\setting_files\" file_name ".ini"
    arr_tab1_last_closed_Setting := load_from_ini("arr_tab1_last_closed_Setting", 1, file_name).Clone()
    Show_now_enabled_settting_slot_frame(arr_tab1_last_closed_Setting[1]) ;顯示設定檔slot綠色邊框
    arr_tab1_each_buff_setting_path := load_from_ini("arr_tab1_each_buff_setting_path", 1, file_name).Clone()    

    loop (arrobj_text_SL_slot_name.Length) {
        arr_tab1_each_buff_setting_path[A_Index] := file_path_be_moved_check(arr_tab1_each_buff_setting_path[A_Index], "ini")
        if FileExist(arr_tab1_each_buff_setting_path[A_Index]) { 
            ;將儲存路徑中的檔名取出放入textGUI中
            SplitPath arr_tab1_each_buff_setting_path[A_Index], , , , &setting_file_name
            arrobj_text_SL_slot_name[A_Index].Value := setting_file_name
        }
    }
    save_into_ini(arr_tab1_each_buff_setting_path, "arr_tab1_each_buff_setting_path", 1, file_name)
    arr_ALL_Classes := load_from_ini("arr_ALL_Classes", 1, file_name).Clone()
    DDL_Buff_Class1.Delete() ; Delete all existing items
    local arr_temp_2 := [""]
    for , value in arr_ALL_Classes
        {
        arr_temp_2[1] := value
        DDL_Buff_Class1.add(arr_temp_2) ; Add new items
    }
    arr_ALL_Classes_pic_folder := load_from_ini("arr_ALL_Classes_pic_folder", 1, file_name).Clone()
    arr_ALL_Classes_array := load_from_ini("arr_ALL_Classes_array", 1, file_name).Clone()
    arr3d_temp_1 := []
    for name in arr_ALL_Classes_array {
        arr2d_temp_1 := load_from_ini(name, 2, file_name).Clone()     ;將ini中含有arr_ALL_Classes_array的矩陣名段落的資料存入
        arr3d_temp_1.Push(arr2d_temp_1)
    }
    arr_ALL_Classes_array := arr3d_temp_1.Clone()
}


enable_last_closed_Setting(){
    ;取得螢幕範圍大小並避免GUI跑出螢幕範圍
    SysGetCount := MonitorGetCount()
    local Min_L := 50, Min_T := 50, Max_R := 50, Max_B := 50
    Loop SysGetCount {
        MonitorGetWorkArea(A_Index, &Monitor_L, &Monitor_Top, &Monitor_R, &Monitor_Bottom) 
        Min_L := Min(Min_L, Monitor_L)
        Min_T := Min(Min_T, Monitor_Top)
        Max_R := Max(Max_R, Monitor_R)
        Max_B := Max(Max_B, Monitor_Bottom)
    }
    ;MonitorGetWorkArea(1, &Monitor_L, &Monitor_Top, &Monitor_R, &Monitor_Bottom) 
    ;Monitor_Width  := Monitor_R - Monitor_L
    ;Monitor_Height := Monitor_Bottom - Monitor_Top
    scrip_x := arr_tab1_last_closed_Setting[2]
    scrip_y := arr_tab1_last_closed_Setting[3]
    ;MainGui.show("w" 653 " h" 568)
    if (scrip_x < Min_L) {
        scrip_x := Min_L
    }
    if (scrip_x > Max_R - 653) {
        scrip_x := Max_R - 653
    }
    if (scrip_y < Min_T) {
        scrip_y := Min_T
    }
    if (scrip_y > Max_B - 568) {
        scrip_y := Max_B - 568
    }
    MainGui.Move( scrip_x, scrip_y)
    ;嘗試仔入上次關閉設定檔，如果不行從slot_1依序嘗試可啟動設定檔
    global Num_Selecting_SL_slot := arr_tab1_last_closed_Setting[1] ;取得General_Settings儲存的上次關閉時設定檔的編號
    local file_Path := arr_tab1_each_buff_setting_path[arr_tab1_last_closed_Setting[1]] ;取得上次關閉設定檔的路徑
    if not (FileExist(file_Path)
    and !RegExMatch(file_Path, "[;``]")
    and check_buff_settings_format(,file_Path) == true) { 
        msgbox "無法成功載入上次關閉時的設定檔ini"
        local count_x := 0
        ;如果不存在可成功讀取設定檔，從slot_1依序嘗試可啟動設定檔
        loop (arr_tab1_each_buff_setting_path.Length) {
            if (A_Index != arr_tab1_last_closed_Setting[1]
            and FileExist(file_Path)
            and !RegExMatch(file_Path, "[;``]")
            and check_buff_settings_format(,file_Path) == true) {
                arr_tab1_last_closed_Setting[1] := A_Index
                Num_Selecting_SL_slot := A_Index
                file_Path := arr_tab1_each_buff_setting_path[A_Index]
                break   
            }
            ++count_x
        }
        if (count_x == arr_tab1_each_buff_setting_path.Length) {
            try FileDelete A_ScriptDir "\setting_files\" "buff_setting_temp" ".ini"
            Create_buff_settings_file("buff_setting_temp")
            arr_tab1_last_closed_Setting[1] := 1
            Num_Selecting_SL_slot := 1
            arr_tab1_each_buff_setting_path[1] := A_ScriptDir "\setting_files\" "buff_setting_temp" ".ini"
            file_Path := A_ScriptDir "\setting_files\" "buff_setting_temp" ".ini"
            msgbox "應用臨時設定檔buff_setting_temp.ini`n臨時設定檔會在每次讀取失敗時重置內容"
        }
    }
    ;開始載入各項設定
    start_load_last_closed_buff_settings_file(,file_Path)
    ;load_buff_settings_file(,file_Path)
    fill_arr_setting_data_into_FWin_setting_GUI()
    fill_array2d_AllLV_data_toLV()
    objects_disabled_state_switch(0)
    FWin_reflash()
    SL_slot_slecetd(Num_Selecting_SL_slot)
    ;顯示設定檔slot綠色邊框
    Show_now_enabled_settting_slot_frame(Num_Selecting_SL_slot)
    ;變更最上方現在設定檔的顯示
    Num_now_buff_settting_num.Value := Num_Selecting_SL_slot
    SplitPath file_Path, , , , &file_name
    text_now_buff_settting_name.Value := file_name
}

Create_buff_settings_file(file_name) {
    local file_Path := A_ScriptDir "\setting_files\" file_name ".ini"
    if !FileExist(file_Path) {
        FileAppend("", file_path)
        FileAppend('`n; 1-5>"名稱","按鍵","持續時間","冷卻時間","圖片位址",', file_path)
        FileAppend('`n; 6-11>"end_SE_type","end_SE_pitch","end_AI_sec","CD_SE_type","CD_SE_pitch","CD_AI_sec"', file_path)
        FileAppend('`n[arr2d_tab1_AllLV_data]`n', file_path)
        FileAppend('`n; 1-6>"啟用懸浮窗","鎖定懸浮窗","懸浮窗座標X","懸浮窗座標Y","圖示大小","圖示間距",', file_path)
        FileAppend('`n; 7-10>"數字大小","數字位置","數字顏色","數字底色"', file_path)
        FileAppend('`n[arr_tab1_FWin_Setting_data]`n', file_path)
        FileAppend('`n; "持續圖片透明度","結束圖片透明度","文字透明度","倒數顯示分鐘"', file_path)
        FileAppend('`n[arr_tab1_FWin_Setting_2_data]`n', file_path)
        FileAppend('`n; "重置timer熱鍵","隱藏視窗熱鍵","重啟程式熱鍵","只在活動視窗啟動","原活動視窗名稱","冷卻按鍵無效"', file_path)
        FileAppend('`n[arr_tab1_Other_Setting_data]`n', file_path)
        FileAppend('`n; "活動視窗名稱"', file_path)
        FileAppend('`n[active_win_name]`n', file_path)
        save_into_ini(arr2d_tab1_AllLV_data, "arr2d_tab1_AllLV_data", 2, file_name)
        save_into_ini(arr_tab1_FWin_Setting_data, "arr_tab1_FWin_Setting_data", 1, file_name)
        save_into_ini(arr_tab1_FWin_Setting_2_data, "arr_tab1_FWin_Setting_2_data", 1, file_name)
        local arr_temp_tab1_Other_Setting_data := arr_tab1_Other_Setting_data.Clone()
        local str_temp_active_win_name := arr_temp_tab1_Other_Setting_data[5]
        arr_temp_tab1_Other_Setting_data[5] := "active_win_name"
        save_into_ini(arr_temp_tab1_Other_Setting_data, "arr_tab1_Other_Setting_data", 1, file_name)
        save_into_ini(str_temp_active_win_name, "active_win_name", 1, file_name)
    }
}

check_buff_settings_format(file_name := "", file_Path := "") {
    chose_file_name_or_file_path(&file_name,&file_Path)
    if !FileExist(file_Path) {
        Show_ToolTip("檔案路徑錯誤", 0, 0, btn_saved_settting_Import)
        return false
    }
    else {
        ; 1-5>"名稱","按鍵","持續時間","冷卻時間","圖片位址",
        ; 6-11>"end_SE_type","end_SE_pitch","end_AI_sec","CD_SE_type","CD_SE_pitch","CD_AI_sec"
        local arr2d_tab1_AllLV_data_type := ["String", "String", "Integer", "Integer", "String", 
            "Integer", "Integer", "Integer", "Integer", "Integer", "Integer"]
        ;檢查ini內是否有需要的全部Section
        local buff_settings_Section_Names := ["arr2d_tab1_AllLV_data", "arr_tab1_FWin_Setting_data", 
            "arr_tab1_FWin_Setting_2_data", "arr_tab1_Other_Setting_data", "active_win_name"]
        local temp_Section_Names := StrSplit(IniRead(file_Path ,,,), "`n")
        local count_x := 0
        for , temp_name in temp_Section_Names {
            for , name in buff_settings_Section_Names {
                if (temp_name == name) {
                    ++count_x
                    break
                }
            }
            if (count_x == 0 and A_Index <= 5) {
                msgbox "設定檔缺少 Section [" buff_settings_Section_Names[A_Index] "]"
                return false
            }
            count_x := 0
        }
        ;檢查arr2d_tab1_AllLV_data各行數量及總行數是否符合
        local arr2d_temp_tab1_AllLV_data := load_from_ini("arr2d_tab1_AllLV_data", 2, , file_Path).Clone()
        local count_x := 0
        for , row in arr2d_temp_tab1_AllLV_data {
                if (row.Length != 11) {
                    msgbox "設定檔 arr2d_temp_tab1_AllLV_data 第 " A_Index " 行長度不為 11"
                    return false
                }
            ++count_x
        }
        if (count_x != 10) {
            msgbox "設定檔 arr2d_temp_tab1_AllLV_data 總行數不為 10"
            return false
        }
        local arr_temp_tab1_FWin_Setting_data := load_from_ini("arr_tab1_FWin_Setting_data", 1, , file_Path).Clone()
        if (arr_temp_tab1_FWin_Setting_data.Length != 10) {
            msgbox "設定檔 FWin_Setting_data 總行數不為 10"
            return false
        }
        loop (10)
            if (arr_temp_tab1_FWin_Setting_data[A_Index] == "") {
                msgbox "設定檔 FWin_Setting_data 前10筆資料中有空值"
                return false
            }
        local arr_temp_tab1_FWin_Setting_2_data := load_from_ini("arr_tab1_FWin_Setting_2_data", 1, , file_Path).Clone()
        if (arr_temp_tab1_FWin_Setting_2_data.Length < 4) {
            msgbox "設定檔 FWin_Setting_2_data 總行數不足 4"
            return false
        }
        loop (3)
            if (arr_temp_tab1_FWin_Setting_2_data[A_Index] == "") {
                msgbox "設定檔 FWin_Setting_2_data 前4筆資料中有空值"
                return false
            }
        local arr_temp_tab1_Other_Setting_data := load_from_ini("arr_tab1_Other_Setting_data", 1, , file_Path).Clone()
        arr_temp_tab1_Other_Setting_data[5] := load_from_ini("active_win_name", 1, , file_Path)[1]
        if (arr_temp_tab1_Other_Setting_data.Length < 6) {
            msgbox "設定檔 arr_tab1_Other_Setting_data 總行數不足 6"
            return false
        }
        loop (6) {
            if (arr_temp_tab1_Other_Setting_data[A_Index]== "") {
                msgbox "設定檔 arr_tab1_Other_Setting_data 前6筆資料中有空值"
                return false
            }
        }
    }
    return true
}

start_load_last_closed_buff_settings_file(file_name := "", file_Path := "") {
    global Selecting_LV_RowNum,arr2d_tab1_AllLV_data, arr_tab1_FWin_Setting_data, arr_tab1_FWin_Setting_2_data, arr_tab1_Other_Setting_data
    chose_file_name_or_file_path(&file_name,&file_Path)
    if FileExist(file_Path) {
        arr2d_tab1_AllLV_data := load_from_ini("arr2d_tab1_AllLV_data", 2,, file_Path).Clone()
        for ,row in arr2d_tab1_AllLV_data {
            if not (row[2] == "" or row[2] == "non") {
                trun_hotkey_ON(row[2], "timer")
            } 
            row[5] := file_path_be_moved_check(row[5], "pic")
            if (FileExist(row[5])) {
                arrobj_all_Pic_tab1_slot[A_Index].Value := row[5]
                if(row[4] == 0) { ;如果是沒有CD的技能預設為黑白(未啟動)
                    Pic_slot_visibility_SW(A_Index, 0)
                }
            }
            else {
                arrobj_all_Pic_tab1_slot[A_Index].Value := ""
                arrobj_all_Pic_tab1_slot[A_Index].Move(, , arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5])
            }
            if (FileExist(trun_flie_path_into_sub_pic_folder(row[5]))) {
                arrobj_all_Pic_child_tab1_slot[A_Index].Value := trun_flie_path_into_sub_pic_folder(row[5])
            }
            else {
                arrobj_all_Pic_child_tab1_slot[A_Index].Value := ""
                arrobj_all_Pic_child_tab1_slot[A_Index].Move(, , arr_tab1_FWin_Setting_data[5]-floor(arr_tab1_FWin_Setting_data[5]/40)*2, arr_tab1_FWin_Setting_data[5]-floor(arr_tab1_FWin_Setting_data[5]/40)*2)
            }
        }
        save_into_ini(arr2d_tab1_AllLV_data, "arr2d_tab1_AllLV_data", 2,, file_Path)
        arr_tab1_FWin_Setting_data := load_from_ini("arr_tab1_FWin_Setting_data", 1,,file_Path).Clone()
        arr_tab1_FWin_Setting_2_data := load_from_ini("arr_tab1_FWin_Setting_2_data", 1,,file_Path).Clone()
        arr_tab1_Other_Setting_data := load_from_ini("arr_tab1_Other_Setting_data", 1,,file_Path).Clone()
        arr_tab1_Other_Setting_data[5] := load_from_ini("active_win_name", 1,,file_Path)[1]
        Bool_FWin_SW1.Value := arr_tab1_FWin_Setting_data[1]
        Bool_lock_FWin.Value := arr_tab1_FWin_Setting_data[2]
        Num_FWin_now_Xaxis.Value := arr_tab1_FWin_Setting_data[3]
        Num_FWin_now_Yaxis.Value := arr_tab1_FWin_Setting_data[4]
        Num_Fwin_Pic_size1.Value := arr_tab1_FWin_Setting_data[5]
        Num_Fwin_gap_of_Pic1.Value := arr_tab1_FWin_Setting_data[6]
        Num_Fwin_Time_Size1.Value := arr_tab1_FWin_Setting_data[7]
        DDL_Fwin_Time_Loc1.Value := arr_tab1_FWin_Setting_data[8]
        CBB_Fwin_Time_num_color1.text := arr_tab1_FWin_Setting_data[9]
        CBB_Fwin_Time_back_color1.text := arr_tab1_FWin_Setting_data[10]
        Num_pic_trns_tab1.Value := arr_tab1_FWin_Setting_2_data[1]
        Num_gray_pic_trns_tab1.Value := arr_tab1_FWin_Setting_2_data[2]
        Num_time_trns_tab1.Value := arr_tab1_FWin_Setting_2_data[3]
        Num_time_show_mins.Value := arr_tab1_FWin_Setting_2_data[4]
        DDL_reset_all_timer_HK1.Text := arr_tab1_Other_Setting_data[1]
        DDL_hide_mainGUI_HK1.Text  := arr_tab1_Other_Setting_data[2]
        DDL_reload_script_HK1.Text := arr_tab1_Other_Setting_data[3]
        if not (arr_tab1_Other_Setting_data[1] == "" or arr_tab1_Other_Setting_data[1] == "non") {
            trun_hotkey_ON(arr_tab1_Other_Setting_data[1], "reset")
        } 
        if not (arr_tab1_Other_Setting_data[2] == "" or arr_tab1_Other_Setting_data[2] == "non") {
            trun_hotkey_ON(arr_tab1_Other_Setting_data[2], "hide")
        } 
        if not (arr_tab1_Other_Setting_data[3] == "" or arr_tab1_Other_Setting_data[3] == "non") {
            trun_hotkey_ON(arr_tab1_Other_Setting_data[3], "reload")
        } 
        Bool_enable_when_winactive_Trig1.Value := arr_tab1_Other_Setting_data[4]
        str_winactive_name1.Text := arr_tab1_Other_Setting_data[5]
        Bool_CD_resettable_Trig1.Value := arr_tab1_Other_Setting_data[6]
        if (Selecting_LV_RowNum > 0) {
            arrobj_all_back_DDL_selected_row_tab1[Selecting_LV_RowNum].Visible := false
        }
        Selecting_LV_RowNum := 0
        DDL_Buff_Class1.Choose(0)
        Str_Buff_name1 := 0
        DDL_Buff_HK1.Choose(0)
        Num_ContT1.Value := 0
        Num_CDT1.Value := 0
        Bool_BuffEnd_SE_Trig1.Value := 0
        Bool_CD_SE_Trig1.Value := 0
        DDL_Buff_list1.Choose(0)
        Num_BuffEnd_SE_IAdv1.Value := 0
        DDL_BuffEnd_SE_type1.Choose(0)
        DDL_BuffEnd_SE_Pitch1.Choose(0)
        Num_CD_SE_IAdv1.Value := 0
        DDL_CD_SE_type1.Choose(0)
        DDL_CD_SE_Pitch1.Choose(0)
    }
    else {
        Show_ToolTip("檔案路徑錯誤", 0, 0, btn_saved_settting_Import)
        return
    }
}

load_buff_settings_file(file_name := "", file_Path := "") {
    global Selecting_LV_RowNum, arr2d_tab1_AllLV_data, arr_tab1_FWin_Setting_data, arr_tab1_FWin_Setting_2_data, arr_tab1_Other_Setting_data
    chose_file_name_or_file_path(&file_name,&file_Path)
    if FileExist(file_Path) {
        for ,row in arr2d_tab1_AllLV_data {
            if not (row[2] == "" or row[2] == "non") {
                trun_hotkey_Off(row[2])
            } 
        }
        arr2d_tab1_AllLV_data := load_from_ini("arr2d_tab1_AllLV_data", 2,,file_Path).Clone()
        for ,row in arr2d_tab1_AllLV_data {
            if not (row[2] == "" or row[2] == "non") {
                trun_hotkey_ON(row[2], "timer")
            } 
            row[5] := file_path_be_moved_check(row[5], "pic")
            if (FileExist(row[5])) {
                arrobj_all_Pic_tab1_slot[A_Index].Value := row[5]
                if(row[4] == 0) { ;如果是沒有CD的技能預設為黑白(未啟動)
                    Pic_slot_visibility_SW(A_Index, 0)
                }
            }
            else {
                arrobj_all_Pic_tab1_slot[A_Index].Value := ""
                arrobj_all_Pic_tab1_slot[A_Index].Move(, , arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5])
            }
            if (FileExist(trun_flie_path_into_sub_pic_folder(row[5]))) {
                arrobj_all_Pic_child_tab1_slot[A_Index].Value := trun_flie_path_into_sub_pic_folder(row[5])
            }
            else {
                arrobj_all_Pic_child_tab1_slot[A_Index].Value := ""
                arrobj_all_Pic_child_tab1_slot[A_Index].Move(, , arr_tab1_FWin_Setting_data[5]-floor(arr_tab1_FWin_Setting_data[5]/40)*2, arr_tab1_FWin_Setting_data[5]-floor(arr_tab1_FWin_Setting_data[5]/40)*2)
            }
        }
        save_into_ini(arr2d_tab1_AllLV_data, "arr2d_tab1_AllLV_data", 2,, file_Path)
        arr_tab1_FWin_Setting_data := load_from_ini("arr_tab1_FWin_Setting_data", 1,,file_Path).Clone()
        arr_tab1_FWin_Setting_2_data := load_from_ini("arr_tab1_FWin_Setting_2_data", 1,,file_Path).Clone()
        arr_tab1_Other_Setting_data := load_from_ini("arr_tab1_Other_Setting_data", 1,,file_Path).Clone()
        arr_tab1_Other_Setting_data[5] := load_from_ini("active_win_name", 1,,file_Path)[1]
        Bool_FWin_SW1.Value := arr_tab1_FWin_Setting_data[1]
        Bool_lock_FWin.Value := arr_tab1_FWin_Setting_data[2]
        Num_FWin_now_Xaxis.Value := arr_tab1_FWin_Setting_data[3]
        Num_FWin_now_Yaxis.Value := arr_tab1_FWin_Setting_data[4]
        Num_Fwin_Pic_size1.Value := arr_tab1_FWin_Setting_data[5]
        Num_Fwin_gap_of_Pic1.Value := arr_tab1_FWin_Setting_data[6]
        Num_Fwin_Time_Size1.Value := arr_tab1_FWin_Setting_data[7]
        DDL_Fwin_Time_Loc1.Value := arr_tab1_FWin_Setting_data[8]
        CBB_Fwin_Time_num_color1.text := arr_tab1_FWin_Setting_data[9]
        CBB_Fwin_Time_back_color1.text := arr_tab1_FWin_Setting_data[10]
        Num_pic_trns_tab1.Value := arr_tab1_FWin_Setting_2_data[1]
        Num_gray_pic_trns_tab1.Value := arr_tab1_FWin_Setting_2_data[2]
        Num_time_trns_tab1.Value := arr_tab1_FWin_Setting_2_data[3]
        Num_time_show_mins.Value := arr_tab1_FWin_Setting_2_data[4]
        DDL_reset_all_timer_HK1.Text := arr_tab1_Other_Setting_data[1]
        DDL_hide_mainGUI_HK1.Text  := arr_tab1_Other_Setting_data[2]
        DDL_reload_script_HK1.Text := arr_tab1_Other_Setting_data[3]
        Bool_enable_when_winactive_Trig1.Value := arr_tab1_Other_Setting_data[4]
        str_winactive_name1.Text := arr_tab1_Other_Setting_data[5]
        Bool_CD_resettable_Trig1.Value := arr_tab1_Other_Setting_data[6]
        if (Selecting_LV_RowNum > 0) {
            arrobj_all_back_DDL_selected_row_tab1[Selecting_LV_RowNum].Visible := false
        }
        Selecting_LV_RowNum := 0
        DDL_Buff_Class1.Choose(0)
        Str_Buff_name1 := 0
        DDL_Buff_HK1.Choose(0)
        Num_ContT1.Value := 0
        Num_CDT1.Value := 0
        Bool_BuffEnd_SE_Trig1.Value := 0
        Bool_CD_SE_Trig1.Value := 0
        DDL_Buff_list1.Choose(0)
        Num_BuffEnd_SE_IAdv1.Value := 0
        DDL_BuffEnd_SE_type1.Choose(0)
        DDL_BuffEnd_SE_Pitch1.Choose(0)
        Num_CD_SE_IAdv1.Value := 0
        DDL_CD_SE_type1.Choose(0)
        DDL_CD_SE_Pitch1.Choose(0)
    }
    else {
        Show_ToolTip("檔案路徑錯誤", 0, 0, btn_saved_settting_Import)
        return
    }
}

save_arr2d_tab1_AllLV_data_into_file(file_name := "", file_Path := "") {
    chose_file_name_or_file_path(&file_name,&file_Path)
    if FileExist(file_Path) {
        save_into_ini(arr2d_tab1_AllLV_data, "arr2d_tab1_AllLV_data", 2,, file_Path)
    }
    else {
        Show_ToolTip("檔案路徑錯誤", 0, 0, btn_saved_settting_Import)
        return
    }
}

save_Fwin_settings_into_file(file_name := "", file_Path := "") {
    chose_file_name_or_file_path(&file_name,&file_Path)
    if FileExist(file_Path) {
        save_into_ini(arr_tab1_FWin_Setting_data, "arr_tab1_FWin_Setting_data", 1,, file_Path)
        save_into_ini(arr_tab1_FWin_Setting_2_data, "arr_tab1_FWin_Setting_2_data", 1,, file_Path)
        local arr_temp_tab1_Other_Setting_data := arr_tab1_Other_Setting_data.Clone()
        local str_temp_active_win_name := arr_temp_tab1_Other_Setting_data[5]
        arr_temp_tab1_Other_Setting_data[5] := "active_win_name"
        save_into_ini(arr_temp_tab1_Other_Setting_data, "arr_tab1_Other_Setting_data", 1,, file_Path)
        save_into_ini(str_temp_active_win_name, "active_win_name", 1,, file_Path)
    }
    else {
        Show_ToolTip("檔案路徑錯誤", 0, 0, btn_saved_settting_Import)
        return
    }
}

Show_now_enabled_settting_slot_frame(slot_num) {
    loop (arrobj_back_SL_slot_frame.Length) {
        if (slot_num == A_Index) {
            arrobj_back_SL_slot_frame[A_Index].Visible := true
        }
        else {
            arrobj_back_SL_slot_frame[A_Index].Visible := false
        }
    }  
}

enable_saved_settting(*) {
    global arr_tab1_last_closed_Setting, arr_tab1_each_buff_setting_path, Num_Selecting_SL_slot
    local file_Path := arr_tab1_each_buff_setting_path[Num_Selecting_SL_slot]
    SplitPath file_Path, , , , &file_name
    ;file_Path := A_ScriptDir "\setting_files\" file_Name ".ini"
    ; if !IsSet(saved_settting_enable_green_frame_state) { ;當綠燈狀態array不存在時建立
    ;     global saved_settting_enable_green_frame_state := Array(0,0,0,0,0,0,0,0)
    ; }
    if (RegExMatch(file_name, "[;``]")) { ;字串包含 ; 或 ,
        Show_ToolTip("<= 名稱不可包含 ' `; ' 或 ' `` ' ", -20, -18, arrobj_text_SL_slot_name[Num_Selecting_SL_slot])
        return
    }
    ; if (check_buff_settings_format(,file_Path) == false) {
    ;     return
    ; }
    if (FileExist(file_Path) and check_buff_settings_format(,file_Path) == true) {
        load_buff_settings_file(,file_Path)
        stop_all_countdown_for_SL()
        fill_arr_setting_data_into_FWin_setting_GUI()
        fill_array2d_AllLV_data_toLV()
        objects_disabled_state_switch(0)
        FWin_reflash()
        ;顯示設定檔slot綠色邊框
        Show_now_enabled_settting_slot_frame(Num_Selecting_SL_slot)
        ;變更最上方現在設定檔的顯示
        Num_now_buff_settting_num.Value := Num_Selecting_SL_slot
        text_now_buff_settting_name.Value := file_name
        ;將應用的設定檔編號存入ini檔最後開啟設定檔編號欄
        arr_tab1_last_closed_Setting[1] := Num_Selecting_SL_slot
        save_into_ini(arr_tab1_last_closed_Setting, "arr_tab1_last_closed_Setting", 1,, A_ScriptDir "\setting_files\General_Settings.ini")
        ;顯示應用按鈕綠色邊框
        Fwin_text_color_changed(back_saved_settting_enable, "back", "70ff70", 0)
        saved_settting_enable_green_frame_state[Num_Selecting_SL_slot] := 1
        SetTimer(enable_saved_settting_back_green_Fade_out, 200) 
    }
    else {
        if( file_name == "") {
            Show_ToolTip("尚未匯入設定檔", -20, -18, arrobj_text_SL_slot_name[Num_Selecting_SL_slot])
        }
        else {
            Show_ToolTip("找不到該名稱的設定檔", -20, -18, arrobj_text_SL_slot_name[Num_Selecting_SL_slot])
        }
        return
    }
}

enable_saved_settting_back_green_Fade_out() {
    global saved_settting_enable_green_frame_state
    local count_x := 0
    loop (saved_settting_enable_green_frame_state.Length) {
        if (saved_settting_enable_green_frame_state[A_Index] > 0) {
            switch saved_settting_enable_green_frame_state[A_Index],0 {
                case 4:
                Fwin_text_color_changed(back_saved_settting_enable, "back", "90ff90", 0)
                case 5:
                Fwin_text_color_changed(back_saved_settting_enable, "back", "b0ffb0", 0)
                case 6:
                Fwin_text_color_changed(back_saved_settting_enable, "back", "d0ffd0", 0)
                case 7:  
                Fwin_text_color_changed(back_saved_settting_enable, "back", "不顯示", 0)
                default:
            }
            ++saved_settting_enable_green_frame_state[A_Index]
            if(saved_settting_enable_green_frame_state[A_Index] >= 8) {
                saved_settting_enable_green_frame_state[A_Index] := 0
            }
            ++count_x
        }
    }
    if (count_x == 0) {
        SetTimer(enable_saved_settting_back_green_Fade_out, 0)
        return
    }
}

Import_saved_settting(*) {
    global arr_tab1_last_closed_Setting, arr_tab1_each_buff_setting_path, Num_Selecting_SL_slot
    local file_Path := FileSelect(3, A_ScriptDir "\setting_files" , "選擇設定檔.ini","*ini")
    if (file_Path == "") {
        return
    }
    if (RegExMatch(file_Path, "[;``]")) { ;字串包含 ; 或 ,
        Show_ToolTip("路徑不可包含 ' `; ' 或 ' `` ' ", -100, -18, arrobj_text_SL_slot_name[Num_Selecting_SL_slot])
        return
    }
    if (check_buff_settings_format(,file_Path) == false) {
        return
    }
    SplitPath file_Path, , , , &file_name
    arrobj_text_SL_slot_name[Num_Selecting_SL_slot].Value := file_name
    arr_tab1_each_buff_setting_path[Num_Selecting_SL_slot] := file_Path
    save_into_ini(arr_tab1_each_buff_setting_path, "arr_tab1_each_buff_setting_path", 1,, A_ScriptDir "\setting_files\General_Settings.ini")
    SL_slot_slecetd(Num_Selecting_SL_slot)
    Show_ToolTip("已匯入" file_name "ini", 0, 0, btn_saved_settting_Import)
    return
}

Export_saved_settting(Ctrl, Info) {
    ;local file_Path := A_ScriptDir "\setting_files\" file_name ".ini"
    global num_Selecting_SL_slot
    local now_file_name := arrobj_text_SL_slot_name[Num_Selecting_SL_slot].Value, Str_FileSelect_titel := "匯出設定檔.ini"
    if (now_file_name == "") { ;選擇空slot時填入檔案名稱buff_setting_XXX
        local Num_count_max := 0
        Loop Files A_ScriptDir "\setting_files\*.ini" {
            ; 抓出檔名不含副檔名
            finded_file_name := A_LoopFileName
            finded_file_name := StrReplace(finded_file_name, ".ini")
            ; 找出符合 buff_setting_XXX 格式的檔案
            if (RegExMatch(finded_file_name, "buff_settings_" . "(\d+)$", &finded_file_Num)) {
                if (Integer(finded_file_Num[1]) > Num_count_max) {
                    Num_count_max := Integer(finded_file_Num[1])
                }
            }
        }
        now_file_name := "buff_settings_" Num_count_max + 1
        Str_FileSelect_titel := "建立新設定檔ini"
    }
    local Export_file_Path := FileSelect("S", A_ScriptDir "\setting_files\" now_file_name ".ini", Str_FileSelect_titel, "*ini")
    if (!Export_file_Path or Export_file_Path == "") {
        return
    }
    ; 確保副檔名 .ini
    if !InStr(Export_file_Path, ".ini") {
        Export_file_Path .= ".ini"
    }
    SplitPath Export_file_Path, , , , &file_name
    if (RegExMatch(Export_file_Path, "[;``]")) { ;字串包含 ; 或 ,
        MsgBox "路徑或檔名不可包含 ' `; ' 或 ' `` ' " , 580, 625
        return
    }
    if FileExist(Export_file_Path) {
        choice_YN := MsgBox("檔案已存在：`n" file_name "`n是否覆蓋？", "檔案已存在", "YesNo 32")
        if (choice_YN = "No") {
            return
        }
    }
    local file_Path := arr_tab1_each_buff_setting_path[num_Selecting_SL_slot]
    if (FileExist(file_Path)
    and !RegExMatch(file_Path, "[;``]")
    and check_buff_settings_format(,file_Path) == true) {
        try {
            local arr2d_export_tab1_AllLV_data := load_from_ini("arr2d_tab1_AllLV_data", 2,, file_Path).Clone()
            local arr_export_tab1_FWin_Setting_data := load_from_ini("arr_tab1_FWin_Setting_data", 1,,file_Path).Clone()
            local arr_export_tab1_FWin_Setting_2_data := load_from_ini("arr_tab1_FWin_Setting_2_data", 1,,file_Path).Clone()
            local arr_export_tab1_Other_Setting_data := load_from_ini("arr_tab1_Other_Setting_data", 1,,file_Path).Clone()
            arr_export_tab1_Other_Setting_data[5] := load_from_ini("active_win_name", 1,,file_Path)
        }
        catch {
            msgbox "從設定檔 " arrobj_text_SL_slot_name[Num_Selecting_SL_slot].Value " 讀取資料失敗"
        }
    }
    else {
        msgbox "設定檔 " arrobj_text_SL_slot_name[Num_Selecting_SL_slot].Value " 路徑讀取失敗"
    }
    if !FileExist(Export_file_Path) { ; 為新檔案時建立基本內容
        try { 
            FileAppend("", Export_file_Path)
        } 
        catch {
            MsgBox "新設定檔建立失敗！"
        }
        FileAppend('`n; 1-5>"名稱","按鍵","持續時間","冷卻時間","圖片位址",', Export_file_Path)
        FileAppend('`n; 6-11>"end_SE_type","end_SE_pitch","end_AI_sec","CD_SE_type","CD_SE_pitch","CD_AI_sec"', Export_file_Path)
        FileAppend('`n[arr2d_tab1_AllLV_data]`n', Export_file_Path)
        FileAppend('`n; 1-6>"啟用懸浮窗","鎖定懸浮窗","懸浮窗座標X","懸浮窗座標Y","圖示大小","圖示間距",', Export_file_Path)
        FileAppend('`n; 7-10>"數字大小","數字位置","數字顏色","數字底色"', Export_file_Path)
        FileAppend('`n[arr_tab1_FWin_Setting_data]`n', Export_file_Path)
        FileAppend('`n; "持續圖片透明度","結束圖片透明度","文字透明度","倒數顯示分鐘"', Export_file_Path)
        FileAppend('`n[arr_tab1_FWin_Setting_2_data]`n', Export_file_Path)
        FileAppend('`n; "重置timer熱鍵","隱藏視窗熱鍵","重啟程式熱鍵","只在活動視窗啟動","原活動視窗名稱","冷卻按鍵無效"', Export_file_Path)
        FileAppend('`n[arr_tab1_Other_Setting_data]`n', Export_file_Path)
        FileAppend('`n; "活動視窗名稱"', Export_file_Path)
        FileAppend('`n[active_win_name]`n', Export_file_Path)
    }
    ;嘗試寫入ini矩陣內容
    try {
        save_into_ini(arr2d_export_tab1_AllLV_data, "arr2d_tab1_AllLV_data", 2,, Export_file_Path)
        save_into_ini(arr_export_tab1_FWin_Setting_data, "arr_tab1_FWin_Setting_data", 1,, Export_file_Path)
        save_into_ini(arr_export_tab1_FWin_Setting_2_data, "arr_tab1_FWin_Setting_2_data", 1,, Export_file_Path)
        local arr_temp_tab1_Other_Setting_data := arr_export_tab1_Other_Setting_data.Clone()
        local str_temp_active_win_name := arr_temp_tab1_Other_Setting_data[5]
        arr_temp_tab1_Other_Setting_data[5] := "active_win_name"
        save_into_ini(arr_temp_tab1_Other_Setting_data, "arr_tab1_Other_Setting_data", 1,, Export_file_Path)
        save_into_ini(str_temp_active_win_name, "active_win_name", 1,, Export_file_Path)
        Show_ToolTip("已匯出" file_name ".ini", 0, 0, btn_saved_settting_Export)
        return
    }
    catch {
        MsgBox "設定檔匯出失敗！"
        return
    }
}

Create_New_saved_settting(*) {
    global num_Selecting_SL_slot
    ;為空slot時填入檔案名稱buff_setting_XXX
    local Num_count_max := 0
    Loop Files A_ScriptDir "\setting_files\*.ini" {
        ; 抓出檔名不含副檔名
        finded_file_name := A_LoopFileName
        finded_file_name := StrReplace(finded_file_name, ".ini")
        ; 找出符合 buff_setting_XXX 格式的檔案
        if (RegExMatch(finded_file_name, "buff_settings_" . "(\d+)$", &finded_file_Num)) {
            if (Integer(finded_file_Num[1]) > Num_count_max) {
                Num_count_max := Integer(finded_file_Num[1])
            }
        }
    }
    local now_file_name := "buff_settings_" Num_count_max + 1
    local file_Path := FileSelect("S", A_ScriptDir "\setting_files\" now_file_name ".ini", "建立新設定檔ini", "*ini")
    if (!file_Path or file_Path == "") {
        return
    }
    ; 確保副檔名 .ini
    if !InStr(file_Path, ".ini") {
        file_Path .= ".ini"
    }
    SplitPath file_Path, , , , &file_name
    if (RegExMatch(file_Path, "[;``]")) { ;字串包含 ; 或 ,
        MsgBox "路徑或檔名不可包含 ' `; ' 或 ' `` ' " , 580, 625
        return
    }
    if FileExist(file_Path) {
        choice_YN := MsgBox("檔案已存在：`n" file_name "`n是否以新設定檔覆蓋？", "檔案已存在", "YesNo 32")
        if (choice_YN = "No") {
            return
        }
    }
    if !FileExist(file_Path) { ; 為新檔案時建立基本內容
        try { 
            FileAppend("", file_path)
        } 
        catch {
            MsgBox "新設定檔建立失敗！"
        }
        FileAppend('`n; 1-5>"名稱","按鍵","持續時間","冷卻時間","圖片位址",', file_path)
        FileAppend('`n; 6-11>"end_SE_type","end_SE_pitch","end_AI_sec","CD_SE_type","CD_SE_pitch","CD_AI_sec"', file_path)
        FileAppend('`n[arr2d_tab1_AllLV_data]`n', file_path)
        FileAppend('`n; 1-6>"啟用懸浮窗","鎖定懸浮窗","懸浮窗座標X","懸浮窗座標Y","圖示大小","圖示間距",', file_path)
        FileAppend('`n; 7-10>"數字大小","數字位置","數字顏色","數字底色"', file_path)
        FileAppend('`n[arr_tab1_FWin_Setting_data]`n', file_path)
        FileAppend('`n; "持續圖片透明度","結束圖片透明度","文字透明度","倒數顯示分鐘"', file_path)
        FileAppend('`n[arr_tab1_FWin_Setting_2_data]`n', file_path)
        FileAppend('`n; "重置timer熱鍵","隱藏視窗熱鍵","重啟程式熱鍵","只在活動視窗啟動","原活動視窗名稱","冷卻按鍵無效"', file_path)
        FileAppend('`n[arr_tab1_Other_Setting_data]`n', file_path)
        FileAppend('`n; "活動視窗名稱"', file_path)
        FileAppend('`n[active_win_name]`n', file_path)
    }
    ;建立初始化陣列
    local arr2d_export_tab1_AllLV_data := [
        ["","","","","","","","","","",""],["","","","","","","","","","",""],["","","","","","","","","","",""],["","","","","","","","","","",""],
        ["","","","","","","","","","",""],["","","","","","","","","","",""],["","","","","","","","","","",""],["","","","","","","","","","",""],
        ["","","","","","","","","","",""],["","","","","","","","","","",""]
    ]
    local arr_export_tab1_FWin_Setting_data := [1, 0, 640, 360, 40, 0, 12, 2,"Black","F0F0F0"]
    local arr_export_tab1_FWin_Setting_2_data := [255, 255, 255,"","","","","","",""]
    local arr_export_tab1_Other_Setting_data := ["F10", "F11", "F12", 1, "MapleStory Worlds-Artale (繁體中文版)","0","","","","",""]
    ;嘗試寫入ini矩陣內容
    try {
        save_into_ini(arr2d_export_tab1_AllLV_data, "arr2d_tab1_AllLV_data", 2,, file_Path)
        save_into_ini(arr_export_tab1_FWin_Setting_data, "arr_tab1_FWin_Setting_data", 1,, file_Path)
        save_into_ini(arr_export_tab1_FWin_Setting_2_data, "arr_tab1_FWin_Setting_2_data", 1,, file_Path)
        local arr_temp_tab1_Other_Setting_data := arr_export_tab1_Other_Setting_data.Clone()
        local str_temp_active_win_name := arr_temp_tab1_Other_Setting_data[5]
        arr_temp_tab1_Other_Setting_data[5] := "active_win_name"
        save_into_ini(arr_temp_tab1_Other_Setting_data, "arr_tab1_Other_Setting_data", 1,, file_Path)
        save_into_ini(str_temp_active_win_name, "active_win_name", 1,, file_Path)
        Show_ToolTip("已新建" file_name ".ini", 0, 0, btn_saved_settting_Export)
        return
    }
    catch {
        MsgBox "設定檔新建失敗！"
        return
    }
}

clear_saved_settting(*) {
    global Num_Selecting_SL_slot
    if (arr_tab1_last_closed_Setting[1] == Num_Selecting_SL_slot) {
        msgbox "無法清空應用中的設定檔"
        return
    }
    arrobj_text_SL_slot_name[Num_Selecting_SL_slot].Value := ""
    arr_tab1_each_buff_setting_path[Num_Selecting_SL_slot] := ""
    save_into_ini(arr_tab1_each_buff_setting_path, "arr_tab1_each_buff_setting_path", 1,, A_ScriptDir "\setting_files\General_Settings.ini")
    LV_preview_buff_list.Delete()
    text_preview_reset_timer_HK.Value := ""
    text_preview_hide_maingui_HK.Value := ""
    text_preview_reload_script_HK.Value := ""
}

objects_disabled_state_switch(state, objectgroup := "")
{
if (state) {
    state := "-disabled"
    }
else {
    state := "+disabled"
    }
    ;LV_part_objects
    Btn_delete_LVdata1.Opt(state)
    ;if (objectgroup == "Btn_save_buffsetting1" or state := "+disabled") {
        Btn_save_buffsetting1.Opt(state)
    ;}
    Btn_moveup_LVdata1.Opt(state)
    Btn_movedown_LVdata1.Opt(state)
    ;buff_setting_part_objects
    DDL_Buff_Class1.Opt(state)

    Str_Buff_name1.Opt(state)
    DDL_Buff_HK1.Opt(state)
    Num_ContT1.Opt(state)
    Num_CDT1.Opt(state)
    Btn_Pic_File_Path_Selecte.Opt(state)
    Bool_BuffEnd_SE_Trig1.Opt(state)
    Bool_CD_SE_Trig1.Opt(state)
    ;指定空件這個函式可關閉但不可啟用
    if (state := "+disabled") {
    Btn_Pic_File_Path_clear.Opt(state)
    DDL_Buff_list1.Opt(state)
    Btn_Autofill_Buff_list_value.Opt(state)
    Num_BuffEnd_SE_IAdv1.Opt(state)
    DDL_BuffEnd_SE_type1.Opt(state)
    DDL_BuffEnd_SE_Pitch1.Opt(state)
    Btn_select_BuffEnd_wav.Opt(state)
    Str_selected_BuffEnd_wav.Opt(state)
    Num_CD_SE_IAdv1.Opt(state)
    DDL_CD_SE_type1.Opt(state)
    DDL_CD_SE_Pitch1.Opt(state)
    Btn_select_CD_wav.Opt(state)
    Str_selected_CD_wav.Opt(state)
}
}

fill_array2d_AllLV_data_toLV(*) {
    arr_temp_datafill := ["",""] ; arr_newdata_set.Clone()
    count_x := 1
    LV_setted_buff_list.Delete()
    while (count_x <= 10 and arr2d_tab1_AllLV_data[count_x][1] != "") {
        count_y := 1
        for count_y, Length in arr_temp_datafill {
            arr_temp_datafill[count_y] := arr2d_tab1_AllLV_data[count_x][count_y]
        }
        ;sgbox "count_x " count_x "`nname " arr_temp_datafill[1] "`nkey " arr_temp_datafill[2]
        LV_setted_buff_list.add("", count_x, arr_temp_datafill[1], arr_temp_datafill[2])
    ++count_x
    }
    LV_setted_buff_list.ModifyCol(2,"AutoHdr") ;依照內容調整第二行寬度
    LV_setted_buff_list.ModifyCol(3,"AutoHdr") ;依照內容調整第三行寬度
}

fill_sleceted_File_Addr_to_FWin(*) {

}

LV_ItemSelected(GuiCtrlObj, RowIndex, Selected) {
    ;GuiCtrlObj為DDL物件本身
    ;MsgBox GuiCtrlObj.text "`n" Item "`n" Selected
    ; Info.Item: The row number of the item whose selection changed.
    ; Info.Selected: True if the item is now selected, False if deselected.
    ;arr2d_tab1_AllLV_data
    ;1-6>"編號","名稱","按鍵","持續時間","冷卻時間","圖片位址",
    ;7-11>"end_SE_type","end_SE_pitch","end_AI_sec","CD_SE_type","CD_SE_pitch","CD_AI_sec"
    if(Selected) {
        global Selecting_LV_RowNum, buff_red_frame_state, buff_green_frame_state
        DDL_Buff_Class1.Choose(0) ;重設職業欄, 取消選取的項目
        DDL_Buff_list1.Choose(0) ;重設計技能表欄, 取消選取的項目
        if not (Selecting_LV_RowNum == 0 or Selecting_LV_RowNum == "") {
            arrobj_all_back_DDL_selected_row_tab1[Selecting_LV_RowNum].Visible := false
        }
        Selecting_LV_RowNum := RowIndex ;將被選擇的列號存入全域變數
        local the_row_arr2d_tab1_AllLV_data := arr2d_tab1_AllLV_data[RowIndex]
        buff_red_frame_state := 0
        buff_green_frame_state := 0
        Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "不顯示", 0)
        arrobj_all_back_DDL_selected_row_tab1[Selecting_LV_RowNum].Visible := true ;選擇列指示燈亮起
        objects_disabled_state_switch(1) ;將技能選項按鈕disabled
        ;將儲存的技能名稱填入edit控件
        if(the_row_arr2d_tab1_AllLV_data[1] != "non") {
            Str_Buff_name1.Value := the_row_arr2d_tab1_AllLV_data[1]
        }
        else {
            Str_Buff_name1.Value := ""
        }
        ;將儲存的熱鍵填入DDL控件
            count_x := 1
        for count_x, value in arr_AllKBKeys {
            if ( value = the_row_arr2d_tab1_AllLV_data[2]) {
                DDL_Buff_HK1.Value := count_x
            }
        }
        if(the_row_arr2d_tab1_AllLV_data[2] == "" or the_row_arr2d_tab1_AllLV_data[2] == "non") {
            DDL_Buff_HK1.Choose(0) ;data沒有儲存的熱鍵, 重設HK欄, 取消選取的項目
        }
        Num_ContT1.Value := the_row_arr2d_tab1_AllLV_data[3] ;將儲存的持續時間填入edit控件
        Num_CDT1.Value := the_row_arr2d_tab1_AllLV_data[4] ;將儲存的CD時間填入edit控件
        Path_Pic_File_Addr1.Value := the_row_arr2d_tab1_AllLV_data[5] ;將儲存的圖片路徑填入edit控件
        if(not FileExist(Path_Pic_File_Addr1.Text)) {
            Pic_File_Path_clear()
        }
        else {
            Pic_show_File_Selected.Value := Path_Pic_File_Addr1.Value ; 將路徑的圖片顯示在預覽圖上
            Btn_Pic_File_Path_clear.Opt("-disabled") ; enable清空按鈕
        }
        ;如果結束音效type值為無音效0,1
        if (the_row_arr2d_tab1_AllLV_data[6] <= 1) {
            Bool_BuffEnd_SE_Trig1.Value := 0 ;取消勾選控件
            DDL_BuffEnd_SE_type1.Value := 0
            DDL_BuffEnd_SE_Pitch1.Value := 0
            Num_BuffEnd_SE_IAdv1.Value := 0
            }
        else {
            Bool_BuffEnd_SE_Trig1.Value := 1 ;勾選控件
            Num_BuffEnd_SE_IAdv1.Opt("-Disabled")
            DDL_BuffEnd_SE_type1.Opt("-Disabled")
            DDL_BuffEnd_SE_Pitch1.Opt("-Disabled")
            Btn_select_BuffEnd_wav.Opt("-Disabled")
            Str_selected_BuffEnd_wav.Opt("-Disabled")
            DDL_BuffEnd_SE_type1.Value := the_row_arr2d_tab1_AllLV_data[6]
            if (the_row_arr2d_tab1_AllLV_data[6] <= 15) {
                BuffEnd_SE_wav_selecter_switch(0)
                DDL_BuffEnd_SE_Pitch1.Value := the_row_arr2d_tab1_AllLV_data[7]
            }
            else if (the_row_arr2d_tab1_AllLV_data[6] == 16 and FileExist(the_row_arr2d_tab1_AllLV_data[7])) {
                BuffEnd_SE_wav_selecter_switch(1)
                arr_selected_wav_file_path[1] := the_row_arr2d_tab1_AllLV_data[7]
                SplitPath the_row_arr2d_tab1_AllLV_data[7], , , , &file_name
                Str_selected_BuffEnd_wav.Value := file_name
            }
            else {
                BuffEnd_SE_wav_selecter_switch(0)
                Show_ToolTip("找不到wav路徑", 0, 0, DDL_BuffEnd_SE_Pitch1)
                DDL_BuffEnd_SE_Pitch1.Value := 0
            }
            Num_BuffEnd_SE_IAdv1.Value := the_row_arr2d_tab1_AllLV_data[8] ;將結束音效提前值填入控件
        }
        if (the_row_arr2d_tab1_AllLV_data[9] <= 1) {
            Bool_CD_SE_Trig1.Value := 0 ;取消勾選控件
            DDL_CD_SE_type1.Value := 0 
            DDL_CD_SE_Pitch1.Value := 0
            Num_CD_SE_IAdv1.Value := 0
            }
        else {
            Bool_CD_SE_Trig1.Value := 1 ;勾選控件
            Num_CD_SE_IAdv1.Opt("-Disabled")
            DDL_CD_SE_type1.Opt("-Disabled")
            DDL_CD_SE_Pitch1.Opt("-Disabled")
            Btn_select_CD_wav.Opt("-Disabled")
            Str_selected_CD_wav.Opt("-Disabled")
            DDL_CD_SE_type1.Value := the_row_arr2d_tab1_AllLV_data[9]
            if (the_row_arr2d_tab1_AllLV_data[9] <= 15) {
                CD_SE_wav_selecter_switch(0)
                DDL_CD_SE_Pitch1.Value := the_row_arr2d_tab1_AllLV_data[10]
            }
            else if (the_row_arr2d_tab1_AllLV_data[9] == 16 and FileExist(the_row_arr2d_tab1_AllLV_data[10])) {
                CD_SE_wav_selecter_switch(1)
                arr_selected_wav_file_path[2] := the_row_arr2d_tab1_AllLV_data[10]
                SplitPath the_row_arr2d_tab1_AllLV_data[10], , , , &file_name
                Str_selected_CD_wav.Value := file_name
            }
            else {
                CD_SE_wav_selecter_switch(0)
                Show_ToolTip("找不到wav路徑", 0, 0, DDL_CD_SE_Pitch1)
                DDL_CD_SE_Pitch1.Value := 0
            }
            Num_CD_SE_IAdv1.Value := the_row_arr2d_tab1_AllLV_data[11] ;將結束音效提前值填入控件
        }
        ;buff_setting_unsafed_check()
    }
    /*
    else {
        Selecting_LV_RowNum := 0
        return
    }
    */
}

LV_Added_newdata(*)
{
    global Selecting_LV_RowNum
    if(LV_setted_buff_list.GetCount() <= 9) {
        cont_x := 1
        cont_y := 1
        for cont_x, Length in arr_newbuff_name_Col {
            if (arr_newbuff_name_Col[cont_y] == arr2d_tab1_AllLV_data[cont_x][1] )
            {
                cont_x := 1
                ++cont_y
            }
        }
        arr_temp_1 := arr_newdata_set.Clone()
        arr_temp_1[1] := arr_newbuff_name_Col[cont_y]
        LV_setted_buff_list.add("", LV_setted_buff_list.GetCount() + 1, arr_newbuff_name_Col[cont_y],"non")
        arr2d_tab1_AllLV_data[LV_setted_buff_list.GetCount()] := arr_temp_1
        global Num_Selecting_SL_slot
        if (Num_Selecting_SL_slot == arr_tab1_last_closed_Setting[1]) {
            SL_slot_slecetd(arr_tab1_last_closed_Setting[1])
        }
        save_arr2d_tab1_AllLV_data_into_file(,arr_tab1_each_buff_setting_path[arr_tab1_last_closed_Setting[1]])
        ;LV_ItemSelected(LV_setted_buff_list, LV_setted_buff_list.GetCount(), 1)
    ;fill_array2d_AllLV_data_toLV()
    ;arr2d_tab1_AllLV_data[LV_setted_buff_list.GetCount()][1] := LV_setted_buff_list.GetCount() + 1
    }
    else {
        Show_ToolTip("列表上限為10項", 0, 0, Btn_add_new_LVdata1)
        return
    }
}

LV_delete_data(*) {
    global Selecting_LV_RowNum
    if(Selecting_LV_RowNum == "" or Selecting_LV_RowNum == 0) {
        ToolTip "<=尚未選擇目標列表項目" , 297, 142
        SetTimer () => ToolTip(), -3000
        return
    }
    ;stop_all_countdown() ;重置所有計時器
    count_x := Selecting_LV_RowNum ;取用被刪除行的編號
    trun_hotkey_Off(arr2d_tab1_AllLV_data[count_x][2]) ;如果可能停用被刪除列的熱鍵
    ;將下一列的數值依序移動儲存到這一列，直到下一列的列號為10或數值為空值
    while(count_x <= 9 and arr2d_tab1_AllLV_data[count_x + 1][1] != "") {
        count_y := 1
        for , Length in arr_newdata_set {
            arr2d_tab1_AllLV_data[count_x][count_y] := arr2d_tab1_AllLV_data[count_x + 1][count_y]
            ++count_y
        }
        ;將原先圖片替換成新的arr值圖片
        if(FileExist(arr2d_tab1_AllLV_data[count_x][5])) {
            arrobj_all_Pic_tab1_slot[count_x].Value := arr2d_tab1_AllLV_data[count_x][5]
            arrobj_all_Pic_child_tab1_slot[count_x].Value := trun_flie_path_into_sub_pic_folder(arr2d_tab1_AllLV_data[count_x][5])
        }
        else {
            arrobj_all_Pic_tab1_slot[count_x].Value := ""
            arrobj_all_Pic_tab1_slot[count_x].Move(, , arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5])
            arrobj_all_Pic_child_tab1_slot[count_x].Value := ""
            arrobj_all_Pic_child_tab1_slot[count_x].Move(, , arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5])
        }
        arrobj_all_Pic_tab1_slot[count_x].Visible := arrobj_all_Pic_tab1_slot[count_x + 1].Visible
        arrobj_all_Pic_child_tab1_slot[count_x].Visible := arrobj_all_Pic_child_tab1_slot[count_x + 1].Visible
        arr_tab1_timer_state[count_x] := arr_tab1_timer_state[count_x + 1]
        arr_tab1_timer_nowtime[count_x] := arr_tab1_timer_nowtime[count_x + 1]
        arrobj_all_back_time_tab1_slot[count_x].Visible := arrobj_all_back_time_tab1_slot[count_x + 1].Visible
        arrobj_all_time_tab1_slot[count_x].Visible := arrobj_all_time_tab1_slot[count_x + 1].Visible
        ++count_x
    }
    ;刪除最後一列的懸浮窗圖片
    arrobj_all_Pic_tab1_slot[count_x].Value := ""
    arrobj_all_Pic_tab1_slot[count_x].Move(, , arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5])
    arrobj_all_Pic_child_tab1_slot[count_x].Value := ""
    arrobj_all_Pic_child_tab1_slot[count_x].Move(, , arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5])
    arr_tab1_timer_state[count_x] := 0
    arr_tab1_timer_nowtime[count_x] := 0
    arrobj_all_back_time_tab1_slot[count_x].Visible := false
    arrobj_all_time_tab1_slot[count_x].Visible := false
    ount_y := 1
    for count_y, Length in arr_newdata_set {
        arr2d_tab1_AllLV_data[count_x][count_y] := ""
    }
    fill_array2d_AllLV_data_toLV() ;刷新LV表
    arrobj_all_back_DDL_selected_row_tab1[Selecting_LV_RowNum].Visible := false
    Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "", 0) 
    Selecting_LV_RowNum := 0 ;重置被選擇的列號為無
    DDL_Buff_Class1.Choose(0)
    Str_Buff_name1 := 0
    DDL_Buff_HK1.Choose(0)
    Num_ContT1.Value := 0
    Num_CDT1.Value := 0
    Bool_BuffEnd_SE_Trig1.Value := 0
    Bool_CD_SE_Trig1.Value := 0
    DDL_Buff_list1.Choose(0)
    Num_BuffEnd_SE_IAdv1.Value := 0
    DDL_BuffEnd_SE_type1.Choose(0)
    DDL_BuffEnd_SE_Pitch1.Choose(0)
    Num_CD_SE_IAdv1.Value := 0
    DDL_CD_SE_type1.Choose(0)
    DDL_CD_SE_Pitch1.Choose(0)
    objects_disabled_state_switch(0) ;使輸入用的GUI物件disabled
    save_arr2d_tab1_AllLV_data_into_file(,arr_tab1_each_buff_setting_path[arr_tab1_last_closed_Setting[1]])

}

LV_moveup_data(*) {
    global Selecting_LV_RowNum
    if(Selecting_LV_RowNum == "" or Selecting_LV_RowNum == 0) {
        ToolTip "<=尚未選擇目標列表項目" , 297, 142
        SetTimer () => ToolTip(), -3000
        return
    }
    if(Selecting_LV_RowNum <= 1) {
        return
    }
    count_x := 1
    arr_temp_1 := arr_newdata_set.Clone()
    for count_x, Length in arr_temp_1 {
        arr_temp_1[count_x] := arr2d_tab1_AllLV_data[Selecting_LV_RowNum - 1][count_x]
        arr2d_tab1_AllLV_data[Selecting_LV_RowNum - 1][count_x] := arr2d_tab1_AllLV_data[Selecting_LV_RowNum][count_x]
        arr2d_tab1_AllLV_data[Selecting_LV_RowNum][count_x] := arr_temp_1[count_x]
    }
    ;將對調後的圖片位址更新到懸浮窗
    if(FileExist(arr2d_tab1_AllLV_data[Selecting_LV_RowNum - 1][5])) {
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum - 1].Value := arr2d_tab1_AllLV_data[Selecting_LV_RowNum - 1][5]
        arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum - 1].Value := trun_flie_path_into_sub_pic_folder(arr2d_tab1_AllLV_data[Selecting_LV_RowNum - 1][5])
    }
    else {
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum - 1].Value := ""
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum - 1].Move(, , arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5])
        arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum - 1].Value := ""
        arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum - 1].Move(, , arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5])    
    }
    if(FileExist(arr2d_tab1_AllLV_data[Selecting_LV_RowNum][5])) {
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum].Value := arr2d_tab1_AllLV_data[Selecting_LV_RowNum][5]
        arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum].Value := trun_flie_path_into_sub_pic_folder(arr2d_tab1_AllLV_data[Selecting_LV_RowNum][5])
    }
    else {
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum].Value := ""
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum].Move(, , arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5])
        arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum].Value := ""
        arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum].Move(, , arr_tab1_FWin_Setting_data[5]-floor(arr_tab1_FWin_Setting_data[5]/40)*2, arr_tab1_FWin_Setting_data[5]-floor(arr_tab1_FWin_Setting_data[5]/40)*2)
    }
    if (arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum - 1].Visible != arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum].Visible) {
        Pic_slot_visibility_SW(Selecting_LV_RowNum - 1, !arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum - 1].Visible)
        Pic_slot_visibility_SW(Selecting_LV_RowNum, !arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum].Visible)
    }
    ;對調計時器時間
    arr_tab1_timer_state[Selecting_LV_RowNum - 1] := 1
    arr_tab1_timer_state[Selecting_LV_RowNum] := 1
    count_x := arr_tab1_timer_nowtime[Selecting_LV_RowNum - 1]
    arr_tab1_timer_nowtime[Selecting_LV_RowNum - 1] := arr_tab1_timer_nowtime[Selecting_LV_RowNum]
    arr_tab1_timer_nowtime[Selecting_LV_RowNum] := count_x
    ;對調倒數時間顯示狀態
    count_x := arrobj_all_back_time_tab1_slot[Selecting_LV_RowNum - 1].Visible
    arrobj_all_back_time_tab1_slot[Selecting_LV_RowNum - 1].Visible := arrobj_all_back_time_tab1_slot[Selecting_LV_RowNum].Visible
    arrobj_all_back_time_tab1_slot[Selecting_LV_RowNum].Visible := count_x
    count_x := arrobj_all_time_tab1_slot[Selecting_LV_RowNum - 1].Visible
    arrobj_all_time_tab1_slot[Selecting_LV_RowNum - 1].Visible := arrobj_all_time_tab1_slot[Selecting_LV_RowNum].Visible
    arrobj_all_time_tab1_slot[Selecting_LV_RowNum].Visible := count_x
    ;show_data_arry()
    fill_array2d_AllLV_data_toLV()
    arrobj_all_back_DDL_selected_row_tab1[Selecting_LV_RowNum].Visible := false
    Selecting_LV_RowNum := Selecting_LV_RowNum - 1
    arrobj_all_back_DDL_selected_row_tab1[Selecting_LV_RowNum].Visible := true
    LV_setted_buff_list.Modify(Selecting_LV_RowNum,"Select")
    save_arr2d_tab1_AllLV_data_into_file(,arr_tab1_each_buff_setting_path[arr_tab1_last_closed_Setting[1]])

}

LV_movedown_data(*) {
    global Selecting_LV_RowNum
    if(Selecting_LV_RowNum == "" or Selecting_LV_RowNum == 0) {
        ToolTip "<=尚未選擇目標列表項目" , 297, 142
        SetTimer () => ToolTip(), -3000
        return
    }
    if(Selecting_LV_RowNum >= 10 or Selecting_LV_RowNum >= LV_setted_buff_list.GetCount()) {
        return
    }
    count_x := 1
    arr_temp_1 := arr_newdata_set.Clone()
    for count_x, Length in arr_temp_1 {
        arr_temp_1[count_x] := arr2d_tab1_AllLV_data[Selecting_LV_RowNum + 1][count_x]
        arr2d_tab1_AllLV_data[Selecting_LV_RowNum + 1][count_x] := arr2d_tab1_AllLV_data[Selecting_LV_RowNum][count_x]
        arr2d_tab1_AllLV_data[Selecting_LV_RowNum][count_x] := arr_temp_1[count_x]
    }
    ;將對調後的圖片位址更新到懸浮窗
    if(FileExist(arr2d_tab1_AllLV_data[Selecting_LV_RowNum + 1][5])) {
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum + 1].Value := arr2d_tab1_AllLV_data[Selecting_LV_RowNum + 1][5]
        arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum + 1].Value := trun_flie_path_into_sub_pic_folder(arr2d_tab1_AllLV_data[Selecting_LV_RowNum + 1][5])
    }
    else {
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum + 1].Value := ""
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum + 1].Move(, , arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5])
        arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum + 1].Value := ""
        arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum + 1].Move(, , arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5])
    }
    if(FileExist(arr2d_tab1_AllLV_data[Selecting_LV_RowNum][5])) {
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum].Value := arr2d_tab1_AllLV_data[Selecting_LV_RowNum][5]
        arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum].Value := trun_flie_path_into_sub_pic_folder(arr2d_tab1_AllLV_data[Selecting_LV_RowNum][5])
    }
    else {
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum].Value := ""
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum].Move(, , arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5])
        arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum].Value := ""
        arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum].Move(, , arr_tab1_FWin_Setting_data[5]-floor(arr_tab1_FWin_Setting_data[5]/40)*2, arr_tab1_FWin_Setting_data[5]-floor(arr_tab1_FWin_Setting_data[5]/40)*2)
    }
    if (arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum + 1].Visible != arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum].Visible) {
        Pic_slot_visibility_SW(Selecting_LV_RowNum + 1, !arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum + 1].Visible)
        Pic_slot_visibility_SW(Selecting_LV_RowNum, !arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum].Visible)
    }
    ;對調計時器時間
    arr_tab1_timer_state[Selecting_LV_RowNum + 1] := 1
    arr_tab1_timer_state[Selecting_LV_RowNum] := 1
    count_x := arr_tab1_timer_nowtime[Selecting_LV_RowNum + 1]
    arr_tab1_timer_nowtime[Selecting_LV_RowNum + 1] := arr_tab1_timer_nowtime[Selecting_LV_RowNum]
    arr_tab1_timer_nowtime[Selecting_LV_RowNum] := count_x
    ;對調倒數時間顯示狀態
    count_x := arrobj_all_back_time_tab1_slot[Selecting_LV_RowNum + 1].Visible
    arrobj_all_back_time_tab1_slot[Selecting_LV_RowNum + 1].Visible := arrobj_all_back_time_tab1_slot[Selecting_LV_RowNum].Visible
    arrobj_all_back_time_tab1_slot[Selecting_LV_RowNum].Visible := count_x
    count_x := arrobj_all_time_tab1_slot[Selecting_LV_RowNum + 1].Visible
    arrobj_all_time_tab1_slot[Selecting_LV_RowNum + 1].Visible := arrobj_all_time_tab1_slot[Selecting_LV_RowNum].Visible
    arrobj_all_time_tab1_slot[Selecting_LV_RowNum].Visible := count_x    ;show_data_arry()
    fill_array2d_AllLV_data_toLV()
    arrobj_all_back_DDL_selected_row_tab1[Selecting_LV_RowNum].Visible := false
    Selecting_LV_RowNum := Selecting_LV_RowNum + 1
    arrobj_all_back_DDL_selected_row_tab1[Selecting_LV_RowNum].Visible := true
    LV_setted_buff_list.Modify(Selecting_LV_RowNum,"+Select")
    save_arr2d_tab1_AllLV_data_into_file(,arr_tab1_each_buff_setting_path[arr_tab1_last_closed_Setting[1]])
}

trun_flie_path_into_sub_pic_folder(pic_path) {
    SplitPath pic_path, &OutFileName, &OutDir
    ;msgbox pic_path "`n" OutDir "\" sub_pic_folder_name "\" OutFileName
    return OutDir "\" sub_pic_folder_name "\" OutFileName
    ;FoundPos1 := InStr(pic_path, "\" , , -1)
    ;return SubStr(pic_path, 1, FoundPos1) . sub_pic_folder_name "\" . SubStr(pic_path, FoundPos1 + 1)
}

fill_now_buffsetting_to_data_array(ctrl*) {
    global Selecting_LV_RowNum
    if(Selecting_LV_RowNum == "" or Selecting_LV_RowNum == 0) {
        ToolTip "<=尚未選擇目標列表項目" , 297, 142
        SetTimer () => ToolTip(), -3000
        return
    }
    if(Str_Buff_name1.Text == "") {
        Str_Buff_name1.Text := "non"
        ;ToolTip "<= 尚未輸入名稱" , 611, 128
        ;SetTimer () => ToolTip(), -3000
        ;return
    }
    else if (RegExMatch(Str_Buff_name1.Text, "[;``]")) { ;字串包含 ; 或 ,
        Show_ToolTip("<= 名稱不可包含 ' `; ' 或 ' `` ' ", 0, -25, Str_Buff_name1)
        return
    }

    str_atemp_Buff_HK1 := DDL_Buff_HK1.Text
    if(str_atemp_Buff_HK1 == "") {
        str_atemp_Buff_HK1 := "non"
        ;ToolTip "<= 尚未指定按鍵" , 611, 163
        ;SetTimer () => ToolTip(), -3000
        ;return
    }
    else {
        trun_hotkey_Off(arr2d_tab1_AllLV_data[Selecting_LV_RowNum][2]) ;停止舊的熱鍵
        trun_hotkey_ON(str_atemp_Buff_HK1, "timer") ;註冊新的熱鍵
    }
    ;當選擇的圖片路經有圖片時則放入懸浮窗layer1的圖片欄, 並將gray資料夾內同檔名的檔案放入懸浮窗layer2的圖片欄
    if(FileExist(Path_Pic_File_Addr1.Text)) {
        ;fill_sleceted_File_Addr_to_FWin()
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum].Value := Path_Pic_File_Addr1.Text
        str_atemp_layer2_pic_path := trun_flie_path_into_sub_pic_folder(Path_Pic_File_Addr1.Text)
        ; 用 SubStr 切割並重組
        if(FileExist(str_atemp_layer2_pic_path)) {            
            arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum].Value := str_atemp_layer2_pic_path
        }
        else {
            arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum].Value :=  ""
            arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum].Move(, , arr_tab1_FWin_Setting_data[5]-floor(arr_tab1_FWin_Setting_data[5]/40)*2, arr_tab1_FWin_Setting_data[5]-floor(arr_tab1_FWin_Setting_data[5]/40)*2)
        }
        if(Num_CDT1.Value == 0) {
            ;如果是沒有CD的技能預設為黑白(未啟動)
            Pic_slot_visibility_SW(Selecting_LV_RowNum, 0)
            ;arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum].Visible := true
        }
    }
    else {
        ;如果找不到圖片路徑則訂為"non"
        Path_Pic_File_Addr1.Text := "non"
        ;清空懸浮窗圖片, 避免空值影響將圖片欄大小設為預設值
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum].Value := ""
        arrobj_all_Pic_tab1_slot[Selecting_LV_RowNum].Move(, , arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5])
        arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum].Value := ""
        arrobj_all_Pic_child_tab1_slot[Selecting_LV_RowNum].Move(, , arr_tab1_FWin_Setting_data[5]-floor(arr_tab1_FWin_Setting_data[5]/40)*2, arr_tab1_FWin_Setting_data[5]-floor(arr_tab1_FWin_Setting_data[5]/40)*2)
    }
    ;DDL_BuffEnd_SE_type1為預設音效
    local str_BuffEnd_SE_Pitch_temp := 0, str_CD_SE_Pitch_temp := 0
    if (DDL_BuffEnd_SE_type1.Value <= 15) {
        str_BuffEnd_SE_Pitch_temp := DDL_BuffEnd_SE_Pitch1.Value
        ;當音效取消勾選清空type為0
        if (Bool_BuffEnd_SE_Trig1.Value == 0){
            DDL_BuffEnd_SE_type1.Value := 0
        }
        ;當音效被選擇而沒有選音高時預設為Do
        if (DDL_BuffEnd_SE_type1.Value >= 2 and DDL_BuffEnd_SE_Pitch1.Value == 0) {
            DDL_BuffEnd_SE_Pitch1.Value := 1
            str_BuffEnd_SE_Pitch_temp := 1
        }
    }
    ;DDL_BuffEnd_SE_type1為自選音效
    else {
        ;當音效取消勾選清空type為0
        if (Bool_BuffEnd_SE_Trig1.Value == 0){
            DDL_BuffEnd_SE_type1.Value := 0
            BuffEnd_SE_wav_selecter_switch(0)
        }
        else {
            global arr_selected_wav_file_path
            if (FileExist(arr_selected_wav_file_path[1])) {
                str_BuffEnd_SE_Pitch_temp := arr_selected_wav_file_path[1]
            }
            else {
                Show_ToolTip("沒有找到wav檔案路徑",0 ,0 ,DDL_BuffEnd_SE_type1)
                DDL_BuffEnd_SE_type1.Value := 0
                str_BuffEnd_SE_Pitch_temp := 0
            }
        }
    }
    ;Bool_CD_SE_Trig1.Value為預設音效
    if (DDL_CD_SE_type1.Value <= 15) {
        str_CD_SE_Pitch_temp := DDL_CD_SE_Pitch1.Value
        ;當音效取消勾選清空type為0
        if (Bool_CD_SE_Trig1.Value == 0){
            DDL_CD_SE_type1.Value := 0
        }
        ;當音效被選擇而沒有選音高時預設為Do
        if (DDL_CD_SE_type1.Value >= 2 and DDL_CD_SE_Pitch1.Value == 0) {
            DDL_CD_SE_Pitch1.Value := 1
            str_CD_SE_Pitch_temp := 1
        }
    }
    ;Bool_CD_SE_Trig1.Value為自選音效
    else {
        ;當音效取消勾選清空type為0
        if (Bool_CD_SE_Trig1.Value == 0){
            DDL_CD_SE_type1.Value := 0
            CD_SE_wav_selecter_switch(0)
        }
        else {
            global arr_selected_wav_file_path
            if (FileExist(arr_selected_wav_file_path[2])) {
                str_CD_SE_Pitch_temp := arr_selected_wav_file_path[2]
            }
            else {
                Show_ToolTip("沒有找到wav檔案路徑",0 ,0 ,DDL_CD_SE_type1)
                DDL_CD_SE_type1.Value := 0
                str_CD_SE_Pitch_temp := 0
            }
        }
    }
    arr2d_tab1_AllLV_data[Selecting_LV_RowNum][1] := Str_Buff_name1.text
    arr2d_tab1_AllLV_data[Selecting_LV_RowNum][2] := str_atemp_Buff_HK1
    arr2d_tab1_AllLV_data[Selecting_LV_RowNum][3] := Num_ContT1.Value
    arr2d_tab1_AllLV_data[Selecting_LV_RowNum][4] := Num_CDT1.Value
    arr2d_tab1_AllLV_data[Selecting_LV_RowNum][5] := Path_Pic_File_Addr1.Text
    arr2d_tab1_AllLV_data[Selecting_LV_RowNum][6] := DDL_BuffEnd_SE_type1.Value
    arr2d_tab1_AllLV_data[Selecting_LV_RowNum][7] := str_BuffEnd_SE_Pitch_temp
    arr2d_tab1_AllLV_data[Selecting_LV_RowNum][8] := Num_BuffEnd_SE_IAdv1.Value
    arr2d_tab1_AllLV_data[Selecting_LV_RowNum][9] := DDL_CD_SE_type1.Value
    arr2d_tab1_AllLV_data[Selecting_LV_RowNum][10] := str_CD_SE_Pitch_temp
    arr2d_tab1_AllLV_data[Selecting_LV_RowNum][11] := Num_CD_SE_IAdv1.Value
    fill_array2d_AllLV_data_toLV()
    arrobj_all_time_tab1_slot[Selecting_LV_RowNum].Value := arr2d_tab1_AllLV_data[Selecting_LV_RowNum][3] ;設定計時器時間為儲存的技能持續時間
    buff_setting_unsafed_check()
    if (ctrl.Length >= 1 && IsObject(ctrl[1])) { ;當函式由GUI 呼叫
        save_arr2d_tab1_AllLV_data_into_file(,arr_tab1_each_buff_setting_path[arr_tab1_last_closed_Setting[1]])
    }
    ;>>>>>設定技能圖片
    ;LV_setted_buff_Modify(Selecting_LV_RowNum,"-Select")
    ;Selecting_LV_RowNum := 0
}

Buff_list_win_switch(crtl*) {
    if (crtl == Btn_hide_Buff_list_win) {
        loop (arrobj_Buff_list_win.Length) {
            arrobj_Buff_list_win[A_Index].Visible := false
        }
        Str_Buff_name1.Visible := true
        DDL_Buff_HK1.Visible := true
        Num_ContT1.Visible := true
        UpDown_ContT1.Visible := true
        return
    }
    if (arrobj_Buff_list_win[1].Visible == false) {
        loop (arrobj_Buff_list_win.Length) {
            arrobj_Buff_list_win[A_Index].Visible := true
        }
        Str_Buff_name1.Visible := false
        DDL_Buff_HK1.Visible := false
        Num_ContT1.Visible := false
        UpDown_ContT1.Visible := false
    }
    else {
        loop (arrobj_Buff_list_win.Length) {
            arrobj_Buff_list_win[A_Index].Visible := false
        }
        Str_Buff_name1.Visible := true
        DDL_Buff_HK1.Visible := true
        Num_ContT1.Visible := true
        UpDown_ContT1.Visible := true
    }


}

DDL_Change_Classes_list(Ctrl, Info) {
    ; 'ctrl' is the GuiControl object that raised the event (MyDDL in this case)
    ; 'info' provides additional event-specific information (e.g., for 'Change', it might be empty)
    ; MsgBox "DDL value changed to: " object.Value
    ount_x := 0
    if(Ctrl.Value > 0 and Ctrl.Value <= arr_ALL_Classes_array.Length) {
        arr_temp_1 := arr_ALL_Classes_array[Ctrl.Value].Clone()
    }
        DDL_Buff_list1.Opt("-Disabled")
        DDL_Buff_list1.Delete() ; Delete all existing items
    for count_x, Length in arr_temp_1
        {
        arr_temp_2[1] := (arr_temp_1[count_x][1])
        DDL_Buff_list1.add(arr_temp_2) ; Add new items
    }
}

DDL_Change_Buff_list(Ctrl, Info) {
    if (Ctrl.Value != "" and Ctrl.Value != 0)
    {
        Btn_Autofill_Buff_list_value.Opt("-disabled")
    }
}

Autofill_Buff_list_value(ctrl,Info)
{
    if(DDL_Buff_list1.Value == "" or DDL_Buff_list1.Value == 0) {
        Show_ToolTip("<= 尚未選擇技能", 0, -25, DDL_Buff_list1)
        return
    }
    ;複製職業技能表[第幾種職業][第幾行技能]
    arr_temp_1 := arr_ALL_Classes_array[DDL_Buff_Class1.Value][DDL_Buff_list1.Value].Clone() 
    Str_Buff_name1.Value := arr_temp_1[1]
    Num_ContT1.Value := arr_temp_1[2]
    Num_CDT1.Value := arr_temp_1[3]
    local Bool_found_x := false, arr_pic_ext := ["png","jpg","jpeg","gif","bmp","ico","tif"]
    local pic_path_Classes_folder_no_ext := A_ScriptDir "\buff_pngs\" arr_ALL_Classes_pic_folder[DDL_Buff_Class1.Value] "\" arr_temp_1[4] "."
    local pic_path_pngs_folder_no_ext := A_ScriptDir "\buff_pngs\" arr_temp_1[4] "."
    for (ext_type in arr_pic_ext) {
        local pic_path_1 := pic_path_Classes_folder_no_ext ext_type
        local pic_path_2 := pic_path_pngs_folder_no_ext ext_type
        if (FileExist(pic_path_1)) {
            Path_Pic_File_Addr1.Value := pic_path_1
            Pic_show_File_Selected.Value := pic_path_1
            Bool_found_x := true
            break
        }
        else if (FileExist(pic_path_2)) {
            Path_Pic_File_Addr1.Value := pic_path_2
            Pic_show_File_Selected.Value := pic_path_2
            Bool_found_x := true
            break
        }
    }
    if (Bool_found_x == false) {
        Show_ToolTip("載入圖片 " arr_temp_1[4] " 失敗", -80, -40, Path_Pic_File_Addr1)
        Path_Pic_File_Addr1.Value := "non"
        Pic_show_File_Selected.Value := ""
        Pic_show_File_Selected.move(,,30,30)
        Btn_Pic_File_Path_clear.Opt("+disabled")
    }
    ;Pic_tab1_slot1.Value := A_ScriptDir "\buff_pngs\" arr_temp_1[DDL_Buff_list1.Value][4] ".png"
    Buff_list_win_switch(Btn_hide_Buff_list_win)
    buff_setting_unsafed_check()
}

buff_setting_unsafed_check(*) {
    global Selecting_LV_RowNum, buff_red_frame_state, buff_green_frame_state
    local str_temp_HK1 := (DDL_Buff_HK1.Text == "") ? "non" : DDL_Buff_HK1.Text
    local str_temp_BuffEnd_SE_Pitch := (DDL_BuffEnd_SE_type1.Value == 16) ? arr_selected_wav_file_path[1] : DDL_BuffEnd_SE_Pitch1.Value
    local str_temp_CD_SE_Pitch := (DDL_CD_SE_type1.Value == 16) ? arr_selected_wav_file_path[2] : DDL_CD_SE_Pitch1.Value
    if not (arr2d_tab1_AllLV_data[Selecting_LV_RowNum][1] == Str_Buff_name1.text 
        and arr2d_tab1_AllLV_data[Selecting_LV_RowNum][2] == str_temp_HK1
        and arr2d_tab1_AllLV_data[Selecting_LV_RowNum][3] == Num_ContT1.Value
        and arr2d_tab1_AllLV_data[Selecting_LV_RowNum][4] == Num_CDT1.Value
        and arr2d_tab1_AllLV_data[Selecting_LV_RowNum][5] == Path_Pic_File_Addr1.Text
        and arr2d_tab1_AllLV_data[Selecting_LV_RowNum][6] == DDL_BuffEnd_SE_type1.Value
        and arr2d_tab1_AllLV_data[Selecting_LV_RowNum][7] == str_temp_BuffEnd_SE_Pitch
        and arr2d_tab1_AllLV_data[Selecting_LV_RowNum][8] == Num_BuffEnd_SE_IAdv1.Value
        and arr2d_tab1_AllLV_data[Selecting_LV_RowNum][9] == DDL_CD_SE_type1.Value
        and arr2d_tab1_AllLV_data[Selecting_LV_RowNum][10] == str_temp_CD_SE_Pitch
        and arr2d_tab1_AllLV_data[Selecting_LV_RowNum][11] == Num_CD_SE_IAdv1.Value 
        ) {
            if (buff_red_frame_state == 0) {
                Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "ff5820", 0) 
                buff_red_frame_state := 1
            }
            buff_green_frame_state := 0
            SetTimer(buff_setting_btn_back_red_breathing, 200)
        }
        else {
            Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "70ff70", 0)
            buff_red_frame_state := 0
            buff_green_frame_state := 0
            SetTimer(buff_setting_btn_back_green_Fade_out, 200) 
        }    
}

buff_setting_btn_back_red_breathing() {
global  buff_red_frame_state
    if( Selecting_LV_RowNum == 0) {
        Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "不顯示", 0)
        SetTimer(buff_setting_btn_back_red_breathing, 0)
        return
    }
    if(buff_red_frame_state == 0) {
        SetTimer(buff_setting_btn_back_red_breathing, 0)
        return
    }
    switch buff_red_frame_state,0 {
        case 10:
        Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "ff5820", 0)  
        buff_red_frame_state := 0
        case 1,10:
        Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "ff6430", 0)
        case 2,9:
        Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "ff7C50", 0)
        case 3,8:
        Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "ff9670", 0)
        case 4,7:  
        Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "ffAE90", 0)
        case 5,6: 
        Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "ffC0A0", 0)

        default:
    }
    ++buff_red_frame_state
}

buff_setting_btn_back_green_Fade_out() {
global  buff_red_frame_state, buff_green_frame_state, Selecting_LV_RowNum
    if( Selecting_LV_RowNum == 0) {
        Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "不顯示", 0)
        SetTimer(buff_setting_btn_back_green_Fade_out, 0)
        return
    }
    if(buff_green_frame_state >= 7 or buff_red_frame_state >= 1) {
        buff_green_frame_state := 0
        SetTimer(buff_setting_btn_back_green_Fade_out, 0)
        return
    }
    switch buff_green_frame_state,0 {
        case 3:
        Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "90ff90", 0)
        case 4:
        Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "b0ffb0", 0)
        case 5:
        Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "d0ffd0", 0)
        case 6:  
        Fwin_text_color_changed(back_Btn_save_buffsetting1, "back", "不顯示", 0)
        default:
    }
    ++buff_green_frame_state
}

Pic_File_Path_Selecte(*) {
    path_temp_1 := FileSelect(3, A_ScriptDir "\buff_pngs" , "選擇技能圖示檔案","圖片檔案 (*.png; *.jpg; *.jpeg; *.bmp; *.gif; *.ico; *.tif)")
    if (RegExMatch(path_temp_1, "[;``]")) { ;字串包含 ; 或 ,
        ToolTip "<= 路徑不可包含 ' `; ' 或 ' `` ' " , 580, 320
        SetTimer () => ToolTip(), -3000
        return
    }
    if (path_temp_1 != "") {
        SplitPath path_temp_1, , , &file_ext
        local count_x := 0, arr_pic_ext := ["png","jpg","jpeg","gif","bmp","ico","tif"]
        loop (arr_pic_ext.Length) {
            if (StrCompare(file_ext, arr_pic_ext[A_Index], 0) == 0) {
                count_x := 0
                break
            }
            ++count_x
        }
        if (count_x >= arr_pic_ext.Length) {
            ToolTip "<= 檔案為非支援的格式", 580, 320
            SetTimer () => ToolTip(), -3000
            return
        }
    }
    Path_Pic_File_Addr1.Value := path_temp_1
    Pic_show_File_Selected.Value := path_temp_1
    If (Path_Pic_File_Addr1.Value != "") {
        Btn_Pic_File_Path_clear.Opt("-disabled")
    }
    buff_setting_unsafed_check()
    ;Pic_tab1_slot1.Value := Path_Pic_File_Addr1.Value
}

Pic_File_Path_clear(*) {
    Path_Pic_File_Addr1.Text := "non"
    Pic_show_File_Selected.Value := ""
    Pic_show_File_Selected.move(,,30,30)
    Btn_Pic_File_Path_clear.Opt("+disabled")
    buff_setting_unsafed_check()
}

fill_arr_setting_data_into_FWin_setting_GUI(*) {
    Bool_FWin_SW1.Value := arr_tab1_FWin_Setting_data[1]
    Bool_lock_FWin.Value := arr_tab1_FWin_Setting_data[2]
    Num_FWin_now_Xaxis.Value := arr_tab1_FWin_Setting_data[3]
    Num_FWin_now_Yaxis.Value := arr_tab1_FWin_Setting_data[4]
    Num_Fwin_Pic_size1.Value := arr_tab1_FWin_Setting_data[5]
    Num_Fwin_gap_of_Pic1.Value := arr_tab1_FWin_Setting_data[6]
    Num_Fwin_Time_Size1.Value := arr_tab1_FWin_Setting_data[7]
    DDL_Fwin_Time_Loc1.Value := arr_tab1_FWin_Setting_data[8]
    CBB_Fwin_Time_num_color1.text := arr_tab1_FWin_Setting_data[9] ;數字顏色
    CBB_Fwin_Time_back_color1.text := arr_tab1_FWin_Setting_data[10] ;數字底色
        ; if(arr2d_tab1_AllLV_data[Item][1] != "non") {
        ;     Str_Buff_name1.Value := arr2d_tab1_AllLV_data[Item][1]
        ; }
        ; else {
        ;     Str_Buff_name1.Value := ""
        ; }
        ; ;將儲存的熱鍵填入DDL控件
        ;     count_x := 1
        ; for count_x, value in arr_AllKBKeys {
        ;     if ( value = arr2d_tab1_AllLV_data[Item][2]) {
        ;         DDL_Buff_HK1.Value := count_x
        ;     }
        ; }
        ; if(arr2d_tab1_AllLV_data[Item][2] == "" or arr2d_tab1_AllLV_data[Item][2] == "non") {
        ;     DDL_Buff_HK1.Choose(0) ;data沒有儲存的熱鍵, 重設HK欄, 取消選取的項目
        ; }
    Num_pic_trns_tab1.Value := arr_tab1_FWin_Setting_2_data[1]
    Num_gray_pic_trns_tab1.Value := arr_tab1_FWin_Setting_2_data[2]
    Num_time_trns_tab1.Value := arr_tab1_FWin_Setting_2_data[3]
    DDL_reset_all_timer_HK1.Text := arr_tab1_Other_Setting_data[1]
    DDL_hide_mainGUI_HK1.Text  := arr_tab1_Other_Setting_data[2]
    DDL_reload_script_HK1.Text := arr_tab1_Other_Setting_data[3]
    Bool_enable_when_winactive_Trig1.Value := arr_tab1_Other_Setting_data[4]
    str_winactive_name1.Text := arr_tab1_Other_Setting_data[5]
    Bool_CD_resettable_Trig1.Value := arr_tab1_Other_Setting_data[6]
}

FWin_reflash(ctrl*)
{
    ;更改圖片大小
    if (Num_Fwin_Pic_size1.Value == "") {
        Num_Fwin_Pic_size1.Value := 40
    }
    local P_size := Num_Fwin_Pic_size1.Value
    sub_pic_smaller := floor(P_size/40)
    loop (arrobj_all_Pic_tab1_slot.Length) {
    arrobj_all_Pic_tab1_slot[A_Index].Move( (A_Index - 1) * P_size, , P_size, P_size)
    arrobj_all_Pic_child_tab1_slot[A_Index].Move( (A_Index - 1) * P_size, , P_size - sub_pic_smaller*2, P_size - sub_pic_smaller*2)
    }
    ;檢查圖片間隙
    if (Num_Fwin_gap_of_Pic1.Value == "") {
        Num_Fwin_gap_of_Pic1.Value := 0
    }
    local P_gap := Num_Fwin_gap_of_Pic1.Value
    ;更改字體顏色 waitfix
    ;~~~~~tab1_FWin_setting
    loop (arrobj_all_time_tab1_slot.Length) {
        bool_temp_Fwin_Time_num_changed := Fwin_text_color_changed(arrobj_all_time_tab1_slot[A_Index], "num", CBB_Fwin_Time_num_color1.text, 1)
        bool_temp_Fwin_Time_back_changed := Fwin_text_color_changed(arrobj_all_back_time_tab1_slot[A_Index], "back", CBB_Fwin_Time_back_color1.text, 2)
    }
    ; 更改字體大小
    if (Num_Fwin_Time_Size1.Value == "") {
        Num_Fwin_Time_Size1.Value := 12
    }
    local T_size := Num_Fwin_Time_Size1.Value
    switch DDL_Fwin_Time_Loc1.Value, 0 {
        case 2,3,4,5:
            loop (arrobj_all_time_tab1_slot.Length) {
                try arrobj_all_time_tab1_slot[A_Index].opt("-Right")
                arrobj_all_back_time_tab1_slot[A_Index].Move( , , T_size * 2.4, T_size * 1.3)
                arrobj_all_time_tab1_slot[A_Index].Move( , , T_size * 6, T_size * 1.5)
                arrobj_all_time_tab1_slot[A_Index].SetFont("s" T_size)
                }
        case 6,7,8,9:
            loop (arrobj_all_time_tab1_slot.Length) {
                arrobj_all_time_tab1_slot[A_Index].opt("+Right")
                if (T_size * 2.4 < (P_gap + P_size)) {
                    arrobj_all_back_time_tab1_slot[A_Index].Move( , , T_size * 2.4, T_size * 1.3)
                }
                else {
                    arrobj_all_back_time_tab1_slot[A_Index].Move( , , P_size + P_gap, T_size * 1.3)
                }
                arrobj_all_time_tab1_slot[A_Index].Move( , , P_size + P_gap, T_size * 1.5)
                arrobj_all_time_tab1_slot[A_Index].SetFont("s" T_size)
                }
        default:
            loop (arrobj_all_time_tab1_slot.Length) {
                try arrobj_all_time_tab1_slot[A_Index].opt("-Right")
                arrobj_all_back_time_tab1_slot[A_Index].Move( , , T_size * 2.4, T_size * 1.3)
                arrobj_all_time_tab1_slot[A_Index].Move( , , T_size * 6, T_size * 1.5)
                arrobj_all_time_tab1_slot[A_Index].SetFont("s" T_size)
                }
    }
    ;當不顯示時隱藏所有時間
    if (DDL_Fwin_Time_Loc1.Value == 1) {
        ;topleft:x25,y9
        local TL_X := 25, TL_Y := 9
        loop (arrobj_all_time_tab1_slot.Length) {
            arrobj_all_back_time_tab1_slot[A_Index].Visible := false
            arrobj_all_time_tab1_slot[A_Index].Visible := false
        }
        arrobj_all_Pic_tab1_slot[1].Move( TL_X, TL_Y, , )
        arrobj_all_Pic_child_tab1_slot[1].Move( TL_X + sub_pic_smaller, TL_Y + sub_pic_smaller, , )
        loop (arrobj_all_Pic_tab1_slot.Length - 1) {
            arrobj_all_Pic_tab1_slot[A_Index + 1].Move( TL_X + A_Index * (P_gap + P_size), TL_Y, , )
            arrobj_all_Pic_child_tab1_slot[A_Index + 1].Move( TL_X + sub_pic_smaller + A_Index * (P_gap + P_size), TL_Y + sub_pic_smaller, , )
        }
    } 
    else {
        ;topleft:x25,y9, Time_adj := time_location_Adjustment, Time_back_adj := back_time_location_Adjustment
        local TL_X := 25, TL_Y := 9, Time_adj := floor(P_size / 16), Time_back_adj := floor(T_size / 10)
        ;arrobj_all_Pic_tab1_slot[1].GetPos(&posed_pic_x1, ) ;取得圖片一的xy座標
        ;arrobj_all_time_tab1_slot[1].GetPos(, &posed_time_y1, , )
        ;DDL_Fwin_Time_Loc1 ["不顯示","左上方","左下方","左上角","左下角",])
        ;移動圖片和時間的間距與位置
        switch DDL_Fwin_Time_Loc1.Value, 0 {
            case 2: ;左上方
                ;移動圖片間距與位置
                    arrobj_all_back_time_tab1_slot[1].Move( TL_X + Time_adj - Time_back_adj, TL_Y + Time_back_adj * 1.4, , )
                    arrobj_all_time_tab1_slot[1].Move( TL_X + Time_adj, TL_Y, , )
                    arrobj_all_Pic_tab1_slot[1].Move( TL_X, TL_Y + T_size * 1.5, , )
                    arrobj_all_Pic_child_tab1_slot[1].Move( TL_X + sub_pic_smaller, TL_Y + T_size * 1.5 + sub_pic_smaller, , )
                loop (arrobj_all_Pic_tab1_slot.Length - 1) {
                    arrobj_all_back_time_tab1_slot[A_Index + 1].Move( TL_X + Time_adj - Time_back_adj + A_Index * (P_gap + P_size), TL_Y + Time_back_adj * 1.4, , )
                    arrobj_all_time_tab1_slot[A_Index + 1].Move( TL_X + Time_adj + A_Index * (P_gap + P_size), TL_Y, , )
                    arrobj_all_Pic_tab1_slot[A_Index + 1].Move( TL_X + A_Index * (P_gap + P_size), TL_Y + T_size * 1.5, , )
                    arrobj_all_Pic_child_tab1_slot[A_Index + 1].Move( TL_X + sub_pic_smaller + A_Index * (P_gap + P_size), TL_Y + T_size * 1.5 + sub_pic_smaller, , )
                }    
            case 3: ;左下方
                    arrobj_all_back_time_tab1_slot[1].Move( TL_X + Time_adj - Time_back_adj, TL_Y + P_size - Time_adj / 2 + Time_back_adj * 1.5, , )
                    arrobj_all_time_tab1_slot[1].Move( TL_X + Time_adj, TL_Y + P_size - Time_adj / 2, , )
                    arrobj_all_Pic_tab1_slot[1].Move( TL_X, TL_Y, , )
                    arrobj_all_Pic_child_tab1_slot[1].Move( TL_X + sub_pic_smaller, TL_Y + sub_pic_smaller, , )
                loop (arrobj_all_Pic_tab1_slot.Length - 1) {
                    arrobj_all_back_time_tab1_slot[A_Index + 1].Move( TL_X + Time_adj - Time_back_adj + A_Index * (P_gap + P_size), TL_Y + P_size - Time_adj / 2 + Time_back_adj * 1.5, , )
                    arrobj_all_time_tab1_slot[A_Index + 1].Move( TL_X + Time_adj + A_Index * (P_gap + P_size), TL_Y + P_size - Time_adj / 2, , )
                    arrobj_all_Pic_tab1_slot[A_Index + 1].Move( TL_X + A_Index * (P_gap + P_size), TL_Y, , )
                    arrobj_all_Pic_child_tab1_slot[A_Index + 1].Move( TL_X + sub_pic_smaller + A_Index * (P_gap + P_size), TL_Y + sub_pic_smaller, , )
                }
            case 4: ;左上角
                    arrobj_all_back_time_tab1_slot[1].Move( TL_X + Time_adj - Time_back_adj, TL_Y + Time_back_adj, , )
                    arrobj_all_time_tab1_slot[1].Move( TL_X + Time_adj, TL_Y, , )
                    arrobj_all_Pic_tab1_slot[1].Move( TL_X, TL_Y, , )
                    arrobj_all_Pic_child_tab1_slot[1].Move( TL_X + sub_pic_smaller, TL_Y + sub_pic_smaller, , )
                loop (arrobj_all_Pic_tab1_slot.Length - 1) {
                    arrobj_all_back_time_tab1_slot[A_Index + 1].Move( TL_X + Time_adj - Time_back_adj + A_Index * (P_gap + P_size), TL_Y  + Time_back_adj, , )
                    arrobj_all_time_tab1_slot[A_Index + 1].Move( TL_X + Time_adj + A_Index * (P_gap + P_size), TL_Y, , )
                    arrobj_all_Pic_tab1_slot[A_Index + 1].Move( TL_X + A_Index * (P_gap + P_size), TL_Y, , )
                    arrobj_all_Pic_child_tab1_slot[A_Index + 1].Move( TL_X + sub_pic_smaller + A_Index * (P_gap + P_size), TL_Y + sub_pic_smaller, , )
                }  
            case 5: ;左下角
                    arrobj_all_back_time_tab1_slot[1].Move( TL_X + Time_adj - Time_back_adj, TL_Y + P_size - T_size * 1.4, , )
                    arrobj_all_time_tab1_slot[1].Move( TL_X + Time_adj, TL_Y + P_size - T_size * 1.5, , )
                    arrobj_all_Pic_tab1_slot[1].Move( TL_X, TL_Y, , )
                    arrobj_all_Pic_child_tab1_slot[1].Move( TL_X + sub_pic_smaller, TL_Y + sub_pic_smaller, , )
                loop (arrobj_all_Pic_tab1_slot.Length - 1) {
                    arrobj_all_back_time_tab1_slot[A_Index + 1].Move( TL_X + Time_adj - Time_back_adj + A_Index * (P_gap + P_size), TL_Y + P_size - T_size * 1.4, , )
                    arrobj_all_time_tab1_slot[A_Index + 1].Move( TL_X + Time_adj + A_Index * (P_gap + P_size), TL_Y + P_size - T_size * 1.5, , )
                    arrobj_all_Pic_tab1_slot[A_Index + 1].Move( TL_X + A_Index * (P_gap + P_size), TL_Y, , )
                    arrobj_all_Pic_child_tab1_slot[A_Index + 1].Move( TL_X + sub_pic_smaller + A_Index * (P_gap + P_size), TL_Y + sub_pic_smaller, , )
                }      
            case 6: ;右上方
                    if (T_size * 2.4 < (P_gap + P_size)) {
                        local Timeback_right_x := (P_gap + P_size) - T_size * 2.4
                    }
                    else {
                        local Timeback_right_x := 0
                    }
                    arrobj_all_back_time_tab1_slot[1].Move( TL_X + Timeback_right_x - Time_adj + Time_back_adj, TL_Y + Time_back_adj * 1.4, , )
                    arrobj_all_time_tab1_slot[1].Move( TL_X - Time_adj, TL_Y, , )
                    arrobj_all_Pic_tab1_slot[1].Move( TL_X + P_gap, TL_Y + T_size * 1.5, , )
                    arrobj_all_Pic_child_tab1_slot[1].Move( TL_X + P_gap + sub_pic_smaller, TL_Y + T_size * 1.5 + sub_pic_smaller, , )
                loop (arrobj_all_Pic_tab1_slot.Length - 1) {
                    arrobj_all_back_time_tab1_slot[A_Index + 1].Move( TL_X + Timeback_right_x - Time_adj + Time_back_adj + A_Index * (P_gap + P_size), TL_Y + Time_back_adj * 1.4, , )
                    arrobj_all_time_tab1_slot[A_Index + 1].Move( TL_X - Time_adj + A_Index * (P_gap + P_size), TL_Y, , )
                    arrobj_all_Pic_tab1_slot[A_Index + 1].Move( TL_X + P_gap + A_Index * (P_gap + P_size), TL_Y + T_size * 1.5, , )
                    arrobj_all_Pic_child_tab1_slot[A_Index + 1].Move( TL_X + P_gap + sub_pic_smaller + A_Index * (P_gap + P_size), TL_Y + T_size * 1.5 + sub_pic_smaller, , )
                }    
            case 7: ;右下方
                    if (T_size * 2.4 < (P_gap + P_size)) {
                        local Timeback_right_x := (P_gap + P_size) - T_size * 2.4
                    }
                    else {
                        local Timeback_right_x := 0
                    }
                    arrobj_all_back_time_tab1_slot[1].Move( TL_X + Timeback_right_x - Time_adj + Time_back_adj, TL_Y + P_size - Time_adj / 2 + Time_back_adj * 1.5, , )
                    arrobj_all_time_tab1_slot[1].Move( TL_X - Time_adj, TL_Y + P_size - Time_adj / 2, , )
                    arrobj_all_Pic_tab1_slot[1].Move( TL_X + P_gap, TL_Y, , )
                    arrobj_all_Pic_child_tab1_slot[1].Move( TL_X + P_gap + sub_pic_smaller, TL_Y + sub_pic_smaller, , )
                loop (arrobj_all_Pic_tab1_slot.Length - 1) {
                    arrobj_all_back_time_tab1_slot[A_Index + 1].Move( TL_X + Timeback_right_x - Time_adj + Time_back_adj + A_Index * (P_gap + P_size), TL_Y + P_size - Time_adj / 2 + Time_back_adj * 1.5, , )
                    arrobj_all_time_tab1_slot[A_Index + 1].Move( TL_X - Time_adj + A_Index * (P_gap + P_size), TL_Y + P_size - Time_adj / 2, , )
                    arrobj_all_Pic_tab1_slot[A_Index + 1].Move( TL_X + P_gap + A_Index * (P_gap + P_size), TL_Y, , )
                    arrobj_all_Pic_child_tab1_slot[A_Index + 1].Move( TL_X + P_gap + sub_pic_smaller + A_Index * (P_gap + P_size), TL_Y + sub_pic_smaller, , )
                }
            case 8: ;右上角
                    if (T_size * 2.4 < (P_gap + P_size)) {
                        local Timeback_right_x := (P_gap + P_size) - T_size * 2.4
                    }
                    else {
                        local Timeback_right_x := 0
                    }
                    arrobj_all_back_time_tab1_slot[1].Move( TL_X + Timeback_right_x - Time_adj + Time_back_adj, TL_Y + Time_back_adj, , )
                    arrobj_all_time_tab1_slot[1].Move( TL_X - Time_adj, TL_Y, , )
                    arrobj_all_Pic_tab1_slot[1].Move( TL_X + P_gap, TL_Y, , )
                    arrobj_all_Pic_child_tab1_slot[1].Move( TL_X + P_gap + sub_pic_smaller, TL_Y + sub_pic_smaller, , )
                loop (arrobj_all_Pic_tab1_slot.Length - 1) {
                    arrobj_all_back_time_tab1_slot[A_Index + 1].Move( TL_X + Timeback_right_x - Time_adj + Time_back_adj + A_Index * (P_gap + P_size), TL_Y  + Time_back_adj, , )
                    arrobj_all_time_tab1_slot[A_Index + 1].Move( TL_X - Time_adj + A_Index * (P_gap + P_size), TL_Y, , )
                    arrobj_all_Pic_tab1_slot[A_Index + 1].Move( TL_X + P_gap + A_Index * (P_gap + P_size), TL_Y, , )
                    arrobj_all_Pic_child_tab1_slot[A_Index + 1].Move( TL_X + P_gap + sub_pic_smaller + A_Index * (P_gap + P_size), TL_Y + sub_pic_smaller, , )
                }  
            case 9: ;右下角
                    if (T_size * 2.4 < (P_gap + P_size)) {
                        local Timeback_right_x := (P_gap + P_size) - T_size * 2.4
                    }
                    else {
                        local Timeback_right_x := 0
                    }
                    arrobj_all_back_time_tab1_slot[1].Move( TL_X + Timeback_right_x - Time_adj + Time_back_adj, TL_Y + P_size - T_size * 1.4, , )
                    arrobj_all_time_tab1_slot[1].Move( TL_X - Time_adj, TL_Y + P_size - T_size * 1.5, , )
                    arrobj_all_Pic_tab1_slot[1].Move( TL_X + P_gap, TL_Y, , )
                    arrobj_all_Pic_child_tab1_slot[1].Move( TL_X + P_gap + sub_pic_smaller, TL_Y + sub_pic_smaller, , )
                loop (arrobj_all_Pic_tab1_slot.Length - 1) {
                    arrobj_all_back_time_tab1_slot[A_Index + 1].Move( TL_X + Timeback_right_x - Time_adj + Time_back_adj + A_Index * (P_gap + P_size), TL_Y + P_size - T_size * 1.4, , )
                    arrobj_all_time_tab1_slot[A_Index + 1].Move( TL_X - Time_adj + A_Index * (P_gap + P_size), TL_Y + P_size - T_size * 1.5, , )
                    arrobj_all_Pic_tab1_slot[A_Index + 1].Move( TL_X + P_gap + A_Index * (P_gap + P_size), TL_Y, , )
                    arrobj_all_Pic_child_tab1_slot[A_Index + 1].Move( TL_X + P_gap + sub_pic_smaller + A_Index * (P_gap + P_size), TL_Y + sub_pic_smaller, , )
                }      

            default:
        }
    }
    ; 將懸浮窗移動到edit的x.y座標
    if (Num_FWin_now_Xaxis.Value == "" or Num_FWin_now_Xaxis.Value < 0) {
        Num_FWin_now_Xaxis.Value := 0
    }
    if (Num_FWin_now_Yaxis.Value == "" or Num_FWin_now_Yaxis.Value < 0) {
        Num_FWin_now_Yaxis.Value := 0
    }
    FWinGui_base.Move(Num_FWin_now_Xaxis.Value, Num_FWin_now_Yaxis.Value)
    ; 隱藏gui並依顯示設定重新顯示
    FWinGui_layer3.hide()
    FWinGui_layer2.hide()
    FWinGui_layer1.hide()
    FWinGui_base.hide()

    ;FWinGui_layer1.show("AutoSize")
    ; if(DDL_Fwin_Time_Loc1.Value == 2 or DDL_Fwin_Time_Loc1.Value == 3) {
    ;     FWinGui_base.show("w" TL_X + (Num_Fwin_Pic_size1.Value + Num_Fwin_gap_of_Pic1.Value) * 10 " h" (TL_Y + Num_Fwin_Pic_size1.Value + Num_Fwin_Time_Size1.Value * 1.5))
    ;     FWinGui_layer1.show("h" (TL_Y + Num_Fwin_Pic_size1.Value + Num_Fwin_Time_Size1.Value * 1.5))
    ; }
    FWin_W :=TL_X + (P_size + P_gap) * 10
    FWin_H :=(TL_Y + P_size + T_size * 1.5)
    FWinGui_base.show("w" FWin_W " h" FWin_H)
    FWinGui_layer1.show( "w" FWin_W " h" FWin_H )
    FWinGui_layer2.show( "w" FWin_W " h" FWin_H )
    FWinGui_layer3.show( "w" FWin_W " h" FWin_H )
    if(Bool_FWin_SW1.Value == 0) {
        FWinGui_base.hide()
    }

    ;1-6>"啟用懸浮窗","鎖定懸浮窗","懸浮窗座標X","懸浮窗座標Y","圖示大小","圖示間距",
    ;7-10>"數字大小","數字位置","數字顏色","數字底色"
    arr_tab1_FWin_Setting_data[1] := Bool_FWin_SW1.Value
    arr_tab1_FWin_Setting_data[2] := Bool_lock_FWin.Value
    arr_tab1_FWin_Setting_data[3] := Num_FWin_now_Xaxis.Value
    arr_tab1_FWin_Setting_data[4] := Num_FWin_now_Yaxis.Value
    arr_tab1_FWin_Setting_data[5] := Num_Fwin_Pic_size1.Value
    arr_tab1_FWin_Setting_data[6] := Num_Fwin_gap_of_Pic1.Value
    arr_tab1_FWin_Setting_data[7] := Num_Fwin_Time_Size1.Value
    arr_tab1_FWin_Setting_data[8] := DDL_Fwin_Time_Loc1.Value

    if (bool_temp_Fwin_Time_num_changed == true) {
    arr_tab1_FWin_Setting_data[9] := CBB_Fwin_Time_num_color1.text
    }
    if (bool_temp_Fwin_Time_back_changed == true) {
    arr_tab1_FWin_Setting_data[10] := CBB_Fwin_Time_back_color1.text
    }

    ;~~~~~tab2_FWin_trans_Setting
    if (Num_pic_trns_tab1.Value == "") {
        Num_pic_trns_tab1.Value := 0
    }
    if (Num_pic_trns_tab1.Value == 255) {
        WinSetTransColor(FWinGui_layer1.BackColor, "ahk_id" FWinGui_layer1.Hwnd)
        arr_tab1_FWin_Setting_2_data[1] := Num_pic_trns_tab1.Value
    } 
    else if (Num_pic_trns_tab1.Value >= 0 and Num_pic_trns_tab1.Value < 255) {
        WinSetTransColor(FWinGui_layer1.BackColor " " Num_pic_trns_tab1.Value,"ahk_id" FWinGui_layer1.Hwnd)
        arr_tab1_FWin_Setting_2_data[1] := Num_pic_trns_tab1.Value
    }
    if (Num_gray_pic_trns_tab1.Value == "") {
        Num_gray_pic_trns_tab1.Value := 0
    }
    if (Num_gray_pic_trns_tab1.Value == 255) {
        WinSetTransColor(FWinGui_layer2.BackColor, "ahk_id" FWinGui_layer2.Hwnd)
        arr_tab1_FWin_Setting_2_data[2] := Num_gray_pic_trns_tab1.Value
    }
    else if (Num_gray_pic_trns_tab1.Value >= 0 and Num_gray_pic_trns_tab1.Value < 255) {
        WinSetTransColor(FWinGui_layer2.BackColor " " Num_gray_pic_trns_tab1.Value,"ahk_id" FWinGui_layer2.Hwnd)
        arr_tab1_FWin_Setting_2_data[2] := Num_gray_pic_trns_tab1.Value
    }
    if (Num_time_trns_tab1.Value == "") {
        Num_time_trns_tab1.Value := 0
    }
    if (Num_time_trns_tab1.Value == 255) {
        WinSetTransColor(FWinGui_layer3.BackColor, "ahk_id" FWinGui_layer3.Hwnd)
        arr_tab1_FWin_Setting_2_data[3] := Num_time_trns_tab1.Value
    }
    else  if (Num_time_trns_tab1.Value >= 0 and Num_time_trns_tab1.Value < 255) {
        WinSetTransColor(FWinGui_layer3.BackColor " " Num_time_trns_tab1.Value, "ahk_id" FWinGui_layer3.Hwnd)
        arr_tab1_FWin_Setting_2_data[3] := Num_time_trns_tab1.Value
    }
    if (Num_time_show_mins.Value == "") {
        Num_time_show_mins.Value := 600
    }
    if (Num_time_show_mins.Value >= 0) {
        arr_tab1_FWin_Setting_2_data[4] := Num_time_show_mins.Value  
    }
    Fwin_show_Switch()
    FWin_Location_lock()
    FWin_setting_unsafed_check()
    if (ctrl.Length >= 1 && IsObject(ctrl[1])) { ;當函式由GUI 呼叫
        save_Fwin_settings_into_file(,arr_tab1_each_buff_setting_path[arr_tab1_last_closed_Setting[1]])
    }
}

FWin_setting_unsafed_check(*) {
    global  FWin_red_frame_state, FWin_green_frame_state
    if not (arr_tab1_FWin_Setting_data[1] == Bool_FWin_SW1.Value
        and arr_tab1_FWin_Setting_data[2] == Bool_lock_FWin.Value
        and arr_tab1_FWin_Setting_data[3] == Num_FWin_now_Xaxis.Value
        and arr_tab1_FWin_Setting_data[4] == Num_FWin_now_Yaxis.Value
        and arr_tab1_FWin_Setting_data[5] == Num_Fwin_Pic_size1.Value
        and arr_tab1_FWin_Setting_data[6] == Num_Fwin_gap_of_Pic1.Value
        and arr_tab1_FWin_Setting_data[7] == Num_Fwin_Time_Size1.Value
        and arr_tab1_FWin_Setting_data[8] == DDL_Fwin_Time_Loc1.Value
        and arr_tab1_FWin_Setting_data[9] == CBB_Fwin_Time_num_color1.text
        and arr_tab1_FWin_Setting_data[10] == CBB_Fwin_Time_back_color1.text
        and arr_tab1_FWin_Setting_2_data[1] == Num_pic_trns_tab1.Value
        and arr_tab1_FWin_Setting_2_data[2] == Num_gray_pic_trns_tab1.Value
        and arr_tab1_FWin_Setting_2_data[3] == Num_time_trns_tab1.Value  
        and arr_tab1_FWin_Setting_2_data[4] == Num_time_show_mins.Value   
        ) {
        if(FWin_red_frame_state == 0) {
            Fwin_text_color_changed(back_Btn_FWin_reflash, "back", "ff5820", 0) 
            FWin_red_frame_state := 1
        }
        FWin_green_frame_state := 0
        SetTimer(FWin_setting_btn_back_red_breathing, 200)
    }
    else {
        Fwin_text_color_changed(back_Btn_FWin_reflash, "back", "70ff70", 0)
        FWin_red_frame_state := 0
        FWin_green_frame_state := 0
        SetTimer(FWin_setting_btn_back_green_Fade_out, 200)
        ;SetTimer(() => text_back_green_Fade_out(back_Btn_FWin_reflash),-1)
    }
}

FWin_setting_btn_back_red_breathing() {
global  FWin_red_frame_state
    if(FWin_red_frame_state == 0) {
        SetTimer(FWin_setting_btn_back_red_breathing, 0)
        return
    }
    switch FWin_red_frame_state,0 {
        case 10:
        Fwin_text_color_changed(back_Btn_FWin_reflash, "back", "ff5820", 0)  
        FWin_red_frame_state := 0
        case 1,10:
        Fwin_text_color_changed(back_Btn_FWin_reflash, "back", "ff6430", 0)
        case 2,9:
        Fwin_text_color_changed(back_Btn_FWin_reflash, "back", "ff7C50", 0)
        case 3,8:
        Fwin_text_color_changed(back_Btn_FWin_reflash, "back", "ff9670", 0)
        case 4,7:  
        Fwin_text_color_changed(back_Btn_FWin_reflash, "back", "ffAE90", 0)
        case 5,6: 
        Fwin_text_color_changed(back_Btn_FWin_reflash, "back", "ffC0A0", 0)

        default:
    }
    ++FWin_red_frame_state
}

FWin_setting_btn_back_green_Fade_out() {
global  FWin_red_frame_state, FWin_green_frame_state
    if(FWin_green_frame_state >= 7 or FWin_red_frame_state >= 1) {
        FWin_green_frame_state := 0
        SetTimer(FWin_setting_btn_back_green_Fade_out, 0)
        return
    }
    switch FWin_green_frame_state,0 {
        case 3:
        Fwin_text_color_changed(back_Btn_FWin_reflash, "back", "90ff90", 0)
        case 4:
        Fwin_text_color_changed(back_Btn_FWin_reflash, "back", "b0ffb0", 0)
        case 5:
        Fwin_text_color_changed(back_Btn_FWin_reflash, "back", "d0ffd0", 0)
        case 6:  
                Fwin_text_color_changed(back_Btn_FWin_reflash, "back", "不顯示", 0)
        default:
    }
    ++FWin_green_frame_state
}

FWin_cancel_change(*) {
    Bool_FWin_SW1.Value := arr_tab1_FWin_Setting_data[1]
    Bool_lock_FWin.Value := arr_tab1_FWin_Setting_data[2]
    Num_FWin_now_Xaxis.Value := arr_tab1_FWin_Setting_data[3]
    Num_FWin_now_Yaxis.Value := arr_tab1_FWin_Setting_data[4]
    Num_Fwin_Pic_size1.Value := arr_tab1_FWin_Setting_data[5]
    Num_Fwin_gap_of_Pic1.Value := arr_tab1_FWin_Setting_data[6]
    Num_Fwin_Time_Size1.Value := arr_tab1_FWin_Setting_data[7]
    DDL_Fwin_Time_Loc1.Value := arr_tab1_FWin_Setting_data[8]
    CBB_Fwin_Time_num_color1.text := arr_tab1_FWin_Setting_data[9]
    CBB_Fwin_Time_back_color1.text := arr_tab1_FWin_Setting_data[10]
    Num_pic_trns_tab1.Value := arr_tab1_FWin_Setting_2_data[1]
    Num_gray_pic_trns_tab1.Value := arr_tab1_FWin_Setting_2_data[2]
    Num_time_trns_tab1.Value := arr_tab1_FWin_Setting_2_data[3]
    Fwin_show_Switch()
    FWin_Location_lock()
    FWinGui_base.Move(Num_FWin_now_Xaxis.Value, Num_FWin_now_Yaxis.Value)
    FWin_setting_unsafed_check()
}

Other_setting_apply_change(ctrl*) {
    ;~~~~~tab3_Others_Setting
    if(DDL_reset_all_timer_HK1.Text != "" and DDL_reset_all_timer_HK1.Text != "non") {
        trun_hotkey_Off(arr_tab1_Other_Setting_data[1]) ;停止舊的熱鍵
        trun_hotkey_ON(DDL_reset_all_timer_HK1.Text, "reset") ;註冊新的熱鍵
        arr_tab1_Other_Setting_data[1] := DDL_reset_all_timer_HK1.Text
    }
    else {
        trun_hotkey_Off(arr_tab1_Other_Setting_data[1]) ;停止舊的熱鍵
        arr_tab1_Other_Setting_data[1] := DDL_reset_all_timer_HK1.Text
    }
    if(DDL_hide_mainGUI_HK1.Text != "" and DDL_hide_mainGUI_HK1.Text != "non") {
        trun_hotkey_Off(arr_tab1_Other_Setting_data[2]) ;停止舊的熱鍵
        trun_hotkey_ON(DDL_hide_mainGUI_HK1.Text, "hide") ;註冊新的熱鍵
        arr_tab1_Other_Setting_data[2] := DDL_hide_mainGUI_HK1.Text
    }
    else {
        trun_hotkey_Off(arr_tab1_Other_Setting_data[2]) ;停止舊的熱鍵
        arr_tab1_Other_Setting_data[2] := DDL_hide_mainGUI_HK1.Text
    }
    if(DDL_reload_script_HK1.Text != "" and DDL_reload_script_HK1.Text != "non") {
        trun_hotkey_Off(arr_tab1_Other_Setting_data[3]) ;停止舊的熱鍵
        trun_hotkey_ON(DDL_reload_script_HK1.Text, "reload") ;註冊新的熱鍵
        arr_tab1_Other_Setting_data[3] := DDL_reload_script_HK1.Text
    }
    else {
        trun_hotkey_Off(arr_tab1_Other_Setting_data[3]) ;停止舊的熱鍵
        arr_tab1_Other_Setting_data[3] := DDL_reload_script_HK1.Text
    }
    arr_tab1_Other_Setting_data[4] := Bool_enable_when_winactive_Trig1.Value
    arr_tab1_Other_Setting_data[5] := str_winactive_name1.Text
    arr_tab1_Other_Setting_data[6] := Bool_CD_resettable_Trig1.Value
    if (ctrl.Length >= 1 && IsObject(ctrl[1])) { ;當函式由GUI 呼叫
        save_Fwin_settings_into_file(,arr_tab1_each_buff_setting_path[arr_tab1_last_closed_Setting[1]])
    }
    Other_setting_unsafed_check()
}

Other_setting_unsafed_check(*) {
    global  Other_setting_red_frame_state, Other_setting_green_frame_state
    if not (arr_tab1_Other_Setting_data[1] == ((DDL_reset_all_timer_HK1.Text == "") ? "non" : DDL_reset_all_timer_HK1.Text)
        and arr_tab1_Other_Setting_data[2] == ((DDL_hide_mainGUI_HK1.Text == "") ? "non" : DDL_hide_mainGUI_HK1.Text)
        and arr_tab1_Other_Setting_data[3] == ((DDL_reload_script_HK1.Text == "") ? "non" : DDL_reload_script_HK1.Text)
        and arr_tab1_Other_Setting_data[4] == Bool_enable_when_winactive_Trig1.Value
        and arr_tab1_Other_Setting_data[5] == str_winactive_name1.Text
        and arr_tab1_Other_Setting_data[6] == Bool_CD_resettable_Trig1.Value        
        ) {
        if(Other_setting_red_frame_state == 0) {
            Fwin_text_color_changed(back_Btn_Other_setting_apply_change, "back", "ff5820", 0) 
            Other_setting_red_frame_state := 1
        }
        Other_setting_green_frame_state := 0
        SetTimer(Other_setting_btn_back_red_breathing, 200)
    }
    else {
        Fwin_text_color_changed(back_Btn_Other_setting_apply_change, "back", "70ff70", 0)
        Other_setting_red_frame_state := 0
        Other_setting_green_frame_state := 0
        SetTimer(Other_setting_btn_back_green_Fade_out, 200)
        ;SetTimer(() => text_back_green_Fade_out(back_Btn_Other_setting_reflash),-1)
    }
}

Other_setting_btn_back_red_breathing() {
global  Other_setting_red_frame_state
    if(Other_setting_red_frame_state == 0) {
        SetTimer(Other_setting_btn_back_red_breathing, 0)
        return
    }
    switch Other_setting_red_frame_state,0 {
        case 10:
        Fwin_text_color_changed(back_Btn_Other_setting_apply_change, "back", "ff5820", 0)  
        Other_setting_red_frame_state := 0
        case 1,10:
        Fwin_text_color_changed(back_Btn_Other_setting_apply_change, "back", "ff6430", 0)
        case 2,9:
        Fwin_text_color_changed(back_Btn_Other_setting_apply_change, "back", "ff7C50", 0)
        case 3,8:
        Fwin_text_color_changed(back_Btn_Other_setting_apply_change, "back", "ff9670", 0)
        case 4,7:  
        Fwin_text_color_changed(back_Btn_Other_setting_apply_change, "back", "ffAE90", 0)
        case 5,6: 
        Fwin_text_color_changed(back_Btn_Other_setting_apply_change, "back", "ffC0A0", 0)

        default:
    }
    ++Other_setting_red_frame_state
}

Other_setting_btn_back_green_Fade_out() {
global  Other_setting_red_frame_state, Other_setting_green_frame_state
    if(Other_setting_green_frame_state >= 7 or Other_setting_red_frame_state >= 1) {
        Other_setting_green_frame_state := 0
        SetTimer(Other_setting_btn_back_green_Fade_out, 0)
        return
    }
    switch Other_setting_green_frame_state,0 {
        case 3:
        Fwin_text_color_changed(back_Btn_Other_setting_apply_change, "back", "90ff90", 0)
        case 4:
        Fwin_text_color_changed(back_Btn_Other_setting_apply_change, "back", "b0ffb0", 0)
        case 5:
        Fwin_text_color_changed(back_Btn_Other_setting_apply_change, "back", "d0ffd0", 0)
        case 6:  
                Fwin_text_color_changed(back_Btn_Other_setting_apply_change, "back", "不顯示", 0)
        default:
    }
    ++Other_setting_green_frame_state
}

Other_setting_cancel_change(*) {
    DDL_reset_all_timer_HK1.Text := arr_tab1_Other_Setting_data[1]
    DDL_hide_mainGUI_HK1.Text  := arr_tab1_Other_Setting_data[2]
    DDL_reload_script_HK1.Text := arr_tab1_Other_Setting_data[3]
    Bool_enable_when_winactive_Trig1.Value := arr_tab1_Other_Setting_data[4]
    str_winactive_name1.Text := arr_tab1_Other_Setting_data[5]
    Bool_CD_resettable_Trig1.Value := arr_tab1_Other_Setting_data[6]
    Other_setting_unsafed_check()
}

/*
SL_Fwin_Pic_Scale_Changed(ctrl,Info) {
    ;ctrl.Value為滑塊當前數值, Info為移動滑塊的方式為何, msgbox ctrl.Value "," Info
    count_x := 0
    if(ctrl.Value >= 4) {
    count_x := ctrl.Value * 50 - 100
    }
    else {
    count_x := ctrl.Value * 20 + 20
    }
    Num_Fwin_Pic_Scale1.Value := count_x
}
*/

BuffEnd_SE_option_enable(Ctrl,Info) {
    if(Ctrl.Value == 0) {
        Num_BuffEnd_SE_IAdv1.Opt("+Disabled")
        DDL_BuffEnd_SE_type1.Opt("+Disabled")
        DDL_BuffEnd_SE_Pitch1.Opt("+Disabled")
        Btn_select_BuffEnd_wav.Opt("+Disabled")
        Str_selected_BuffEnd_wav.Opt("+Disabled")
    } 
    else {
        Num_BuffEnd_SE_IAdv1.Opt("-Disabled")
        DDL_BuffEnd_SE_type1.Opt("-Disabled")
        DDL_BuffEnd_SE_Pitch1.Opt("-Disabled")
        Btn_select_BuffEnd_wav.Opt("-Disabled")
        Str_selected_BuffEnd_wav.Opt("-Disabled")
    }
}

BuffEnd_SE_wav_selecter_switch(state) {
    if (state == 0) {
        DDL_BuffEnd_SE_Pitch1.Visible := true
        Btn_select_BuffEnd_wav.Visible := false
        Str_selected_BuffEnd_wav.Visible := false
    }
    else {
        Btn_select_BuffEnd_wav.Visible := true
        Str_selected_BuffEnd_wav.Visible := true
        DDL_BuffEnd_SE_Pitch1.Visible := false
    }
}

CD_SE_option_enable(Ctrl,Info,sw?) {
    if(Ctrl.Value == 0) {
        Num_CD_SE_IAdv1.Opt("+Disabled")
        DDL_CD_SE_type1.Opt("+Disabled")
        DDL_CD_SE_Pitch1.Opt("+Disabled")
        Btn_select_CD_wav.Opt("+Disabled")
        Str_selected_CD_wav.Opt("+Disabled")
    }
    else {
        Num_CD_SE_IAdv1.Opt("-Disabled")
        DDL_CD_SE_type1.Opt("-Disabled")
        DDL_CD_SE_Pitch1.Opt("-Disabled")
        Btn_select_CD_wav.Opt("-Disabled")
        Str_selected_CD_wav.Opt("-Disabled")
    }
}

CD_SE_wav_selecter_switch(state) {
    if (state == 0) {
        DDL_CD_SE_Pitch1.Visible := true
        Btn_select_CD_wav.Visible := false
        Str_selected_CD_wav.Visible := false
    }
    else {
        Btn_select_CD_wav.Visible := true
        Str_selected_CD_wav.Visible := true
        DDL_CD_SE_Pitch1.Visible := false
    }
}

select_wav_file(Ctrl,Info) {
    if(Ctrl == Btn_select_BuffEnd_wav) {
        beep_type := DDL_BuffEnd_SE_type1.Value
        local arr_index_temp := 1
    }
    else if (Ctrl == Btn_select_CD_wav) {
        beep_type := DDL_CD_SE_type1.Value
        local arr_index_temp := 2
    }
    else {
        return
    }
if (beep_type == 16) {
        global arr_selected_wav_file_path
        wav_path_1 := FileSelect(3, A_ScriptDir "\SE_wavs" , "選擇wav音效檔案","音訊檔案 (*.wav)")
        if (wav_path_1 == "") {
            return
        }
        if (RegExMatch(wav_path_1, "[;``]")) { ;字串包含 ; 或 ,
            ToolTip "<= 路徑不可包含 ' `; ' 或 ' `` ' " , 580, 320
            SetTimer () => ToolTip(), -3000
            return
        }
        SplitPath wav_path_1, , , &file_ext, &file_name
        if (StrCompare(file_ext, "wav", 0) != 0) {
            msgbox "副檔名須為.wav"
            return
        }
        ;msgbox "已選擇" wav_path_1
        if (FileExist(wav_path_1)) {
            SoundPlay wav_path_1, false  ; true = 等播完
            arr_selected_wav_file_path[arr_index_temp] := wav_path_1
            if(arr_index_temp == 1) {
                Str_selected_BuffEnd_wav.Value := file_name
            }
            else {
                Str_selected_CD_wav.Value := file_name
            }
        }
        buff_setting_unsafed_check()
    }
}

setting_paly_beep_sound(Ctrl,Info) {
    ;確定由哪個GUI呼叫，並為beep_type和first_pitch賦值
    if(Ctrl == DDL_BuffEnd_SE_type1 or Ctrl == DDL_BuffEnd_SE_Pitch1) {
        beep_type := DDL_BuffEnd_SE_type1.Value
        first_pitch := DDL_BuffEnd_SE_Pitch1.Value
        ;預設音調直接調用paly_beep_sound，自定義使用SoundPlay
        if (beep_type <= 15) {
            BuffEnd_SE_wav_selecter_switch(0)        
            paly_beep_sound(beep_type,first_pitch) 
        }
        else if (beep_type == 16) {
            BuffEnd_SE_wav_selecter_switch(1)
            global arr_selected_wav_file_path
            ;msgbox "已選擇" wav_path_1
            if (FileExist(arr_selected_wav_file_path[1])) {
                SoundPlay arr_selected_wav_file_path[1], false  ; true = 等播完
            }
        }
    }
    else if (Ctrl == DDL_CD_SE_type1 or Ctrl == DDL_CD_SE_Pitch1 ) {
        beep_type := DDL_CD_SE_type1.Value
        first_pitch := DDL_CD_SE_Pitch1.Value
        ;預設音調直接調用paly_beep_sound，自定義使用SoundPlay
        if (beep_type <= 15) {
            CD_SE_wav_selecter_switch(0)
            paly_beep_sound(beep_type,first_pitch) 
        }
        else if (beep_type == 16) {
            CD_SE_wav_selecter_switch(1)
            global arr_selected_wav_file_path
            ;msgbox "已選擇" wav_path_1
            if (FileExist(arr_selected_wav_file_path[2])) {
                SoundPlay arr_selected_wav_file_path[2], false  ; true = 等播完
            }
        }
    }
    else {
        DDL_CD_SE_Pitch1.Visible := true
        Btn_select_CD_wav.Visible := false
        Str_selected_CD_wav.Visible := false
        beep_type := 2
        first_pitch := 1
        paly_beep_sound(beep_type,first_pitch) 
    }
}


paly_beep_sound(beep_type,first_pitch,Ctrl?,Info?) {
    if(beep_type <= 15) {
        if(beep_type <= 1) {
            return
        }    
    
        else if (first_pitch == 0) {
            first_pitch := 1
        }
        global arr_SE_ready_to_play, SE_sound_is_playing
        if(first_pitch > 8) {
            first_pitch := 8
        }
        local pitch_index := 3 + first_pitch ;first_pitch := 1為C3~, pitch_index := 4為C3~
    } 
    ;依照beep_style往arr_SE_ready_to_play加入待奏音符
    switch beep_type, 0 ;0為不區分大小寫
    {
    Case 2 :
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index])
    Case 3 :
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index])
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index])
    Case 4 :
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index])
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index + 1])
    Case 5 :
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index])
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index - 1])
    Case 6 :
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index])
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index])
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index])
    Case 7 :
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index])
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index + 1])
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index + 2])
    Case 8 :
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index])
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index - 1])
        arr_SE_ready_to_play.Push (arr_pitch_A3_to_E5[pitch_index - 2])
    Case 9:
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index])
    Case 10:
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index])
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index])
    Case 11:
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index])
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index + 1])
    Case 12:
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index])
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index - 1])
    Case 13:
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index])
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index])
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index])
    Case 14:
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index])
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index + 1])
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index + 2])
    Case 15:
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index])
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index - 1])
        arr_SE_ready_to_play.Push(arr_pitch_wav_files[pitch_index - 2])
    Case 16:
        arr_SE_ready_to_play.Push(first_pitch)
    Default:
    }
    if (SE_sound_is_playing == 0) {
        SE_sound_is_playing := 1
        SetTimer(Sound_Beep,-1)
    }
    return
}
/*
beep_style：
"1beep","2beep","2beep_rise","2beep_fall","3beep","3beep_rise","3beep_fall"
;0 := no_beep
1 := single_beep
2 := double_beep
3 := double_beep_go_up
4 := double_beep_go_down
5 := triple_beep
6 := triple_beep_go_up
7 := triple_beep_go_down

global arr_SE_types :=  Array(
"SE_off","1beep","2beep","2b_rise","2b_fall","3beep","3b_rise","3b_fall"
)
global arr_pitch_names :=  Array(
"Do(C3)", "Re(D3)",	"Mi(E3)", "Fa(F3)", "So(G3)", "La(A3)",	"Si(B3)", "Do(C4)"
)
global arr_pitch_A3_to_E5 := Array(
    0, 220, 246.93, 261.63, 293.66, 329.62, 349.23, 392, 440, 493.87, 523.25, 587.33, 659.25
)
first_pitch := arr_pitch_names.Value
*/
/*
arr_pitch_A3_to_E5[4]
    Switch first_pitch, 0
    {
    Case "Do(C3)":
        first_pitch := arr_pitch_A3_to_E5[4]
    Case "Re(D3)":
        first_pitch := arr_pitch_A3_to_E5[5]
    Case "Mi(E3)":
        first_pitch := arr_pitch_A3_to_E5[6]
    Case "Fa(F3)":
        first_pitch := arr_pitch_A3_to_E5[7]
    Case "So(G3)":
        first_pitch := arr_pitch_A3_to_E5[8]
    Case "La(A3)":
        first_pitch := arr_pitch_A3_to_E5[9]
    Case "Si(B3)":
        first_pitch := arr_pitch_A3_to_E5[10]
    Case "Do(C4)":
        first_pitch := arr_pitch_A3_to_E5[11]
    Default:
    }
*/
Sound_Beep() {
    global arr_SE_ready_to_play, SE_sound_is_playing
    while (arr_SE_ready_to_play.Has(A_Index)) {
        ;ToolTip Type(arr_SE_ready_to_play[A_Index])
        if (FileExist(arr_SE_ready_to_play[A_Index])) {
            SoundPlay arr_SE_ready_to_play[A_Index], false  ; true = 等播完
            ;Sleep 200    ; 控制播放時間
            ;try SoundPlay ""           ; 強制停止
        }
        else if ( Type(arr_SE_ready_to_play[A_Index]) != "String" ) {
            SoundBeep arr_SE_ready_to_play[A_Index]
        }
    }
    arr_SE_ready_to_play := Array() ;清空arr_SE_ready_to_play的數值
    SE_sound_is_playing := 0 ;將運行狀態重置回0
}

Sound_wav() {
    global arr_SE_ready_to_play_wav, SE_sound_is_playing_wav
    while (arr_SE_ready_to_play_wav.Has(A_Index)) {
    SoundBeep arr_SE_ready_to_play_wav[A_Index]
    }
    arr_SE_ready_to_play_wav := Array() ;清空arr_SE_ready_to_play的數值
    SE_sound_is_playing_wav := 0 ;將運行狀態重置回0
}

start_check_is_no_same_hotkey(ctrl,item) {
    local hotkeyname := ctrl.text
    if (check_is_no_same_hotkey(hotkeyname, ctrl) == false) {
        if (ctrl == DDL_Buff_HK1) {
            try DDL_Buff_HK1.Text :=  arr2d_tab1_AllLV_data[Selecting_LV_RowNum][2]
        } 
        if(ctrl == DDL_reset_all_timer_HK1) {
            try DDL_reset_all_timer_HK1.Text := arr_tab1_Other_Setting_data[1]
        } 
        if(ctrl == DDL_hide_mainGUI_HK1) {
            try DDL_hide_mainGUI_HK1.Text  := arr_tab1_Other_Setting_data[2]
        } 
        if(ctrl == DDL_reload_script_HK1) {
            try DDL_reload_script_HK1.Text := arr_tab1_Other_Setting_data[3]
        }
    }
}

check_is_no_same_hotkey(hotkeyname, ctrl) {
    local count_x := 0, num_row := 0, num_same_key_func_index := 0
    local arr_func_index_name := ["技能按鍵","重置全部計時","隱藏設定視窗","重新啟動程式"]
    if(hotkeyname == "" or hotkeyname == "non") {
        return true
    }
    ;查找重複的熱鍵, 遍歷arr2d_tab1_AllLV_data第二欄和全重置HK, 有已存在的熱鍵時不用再建立
    for _, row in arr2d_tab1_AllLV_data {
        if(row[2] == hotkeyname and ctrl != DDL_Buff_HK1 ) {
            ++count_x
            num_row := A_Index
            num_same_key_func_index := 1
            break
        }
    }
    if (arr_tab1_Other_Setting_data[1] == hotkeyname) {
            ++count_x
            num_same_key_func_index := 2
    }
    if (arr_tab1_Other_Setting_data[2] == hotkeyname) {
            ++count_x
            num_same_key_func_index := 3
    }
    if (arr_tab1_Other_Setting_data[3] == hotkeyname) {
            ++count_x
            num_same_key_func_index := 4
    }
    if(count_x >= 1) {
        if (num_same_key_func_index == 1) {
            Show_ToolTip("按鍵 " hotkeyname " 與 " arr2d_tab1_AllLV_data[num_row][1] " 技能按鍵重複", 0, 0,ctrl)
        } 
        else {
            Show_ToolTip("按鍵 " hotkeyname " 與設定 " arr_func_index_name[num_same_key_func_index] " 按鍵重複", -150, 0,ctrl)
        }
        return false
    }
    return true
}

trun_hotkey_ON(hotkeyname,run_func) {
    local count_x := 0, num_same_key_func_index := 0, num_run_func_index := 0
    local arr_func_index_name := ["技能按鍵","重置全部計時","隱藏設定視窗","重新啟動程式"]
    if(hotkeyname == "" or hotkeyname == "non") {
        return
    }
    switch run_func {
        case "timer", 1 :
            num_run_func_index := 1
        case "reset", 2 :
            num_run_func_index := 2
        case "hide", 3 :
            num_run_func_index := 3
        case "reload", 4 :
            num_run_func_index := 4
        default :
    }
    ;查找重複的熱鍵, 遍歷arr2d_tab1_AllLV_data第二欄和全重置HK, 有已存在的熱鍵時不用再建立
    for _, row in arr2d_tab1_AllLV_data {
        if(row[2] == hotkeyname) {
            ++count_x
            num_same_key_func_index := 1
        }
    }
    if (arr_tab1_Other_Setting_data[1] == hotkeyname) {
            ++count_x
            num_same_key_func_index := 2
    }
    if (arr_tab1_Other_Setting_data[2] == hotkeyname) {
            ++count_x
            num_same_key_func_index := 3
    }
    if (arr_tab1_Other_Setting_data[3] == hotkeyname) {
            ++count_x
            num_same_key_func_index := 4
    }
    if(count_x >= 2) {
        if (num_run_func_index == 1 and num_same_key_func_index >= 2) {
            MsgBox "技能按鍵 " hotkeyname " 未生效`n" hotkeyname " 已經是 " arr_func_index_name[num_same_key_func_index] " 按鍵"
            return
        }
        if (num_run_func_index != 1 and num_run_func_index < num_same_key_func_index) {
            MsgBox "按鍵 " hotkeyname " 已更新設定為`n" arr_func_index_name[num_run_func_index] " 按鍵`n" arr_func_index_name[num_same_key_func_index] " 功能不再生效"
        }
        else if (num_run_func_index != 1 and num_same_key_func_index < num_run_func_index) {
            MsgBox "按鍵 " hotkeyname " 已是設定`n" arr_func_index_name[num_same_key_func_index] " 按鍵`n" arr_func_index_name[num_run_func_index] " 按鍵設定未生效"
            return
        }
    }
    ;特別將~(儲存到存檔熱鍵)轉換成`(定義按下用熱鍵)避免存檔損壞
    if(hotkeyname == "~") {
        hotkeyname := "``"
    }
    try {
        hotkey "*~" hotkeyname,"ON" ;如果可能, 開啟曾被關閉的熱鍵
    }
    if(run_func == "timer" or run_func == 1) {
        hotkey "*~" hotkeyname, main_start_countdown ;設定熱鍵並使其運行計時函式
    }
    else if (run_func == "reset" or run_func == 2) {
        hotkey "*~" hotkeyname, stop_all_countdown ;設定熱鍵並使其運行重置函式
    }
    else if (run_func == "hide" or run_func == 3) {
        hotkey "*~" hotkeyname, MainGui_show_Switch ;設定熱鍵並使其運行重置函式
    }
    else if (run_func == "reload" or run_func == 4) {
        hotkey "*~" hotkeyname, reload_script ;設定熱鍵並使其運行重置函式
    }
}

reload_script(*) {
    Reload
}

trun_hotkey_Off(hotkeyname) {
    count_x := 0
    if(hotkeyname == "" or hotkeyname == "non") {
        return
    }
    ;特別將~(儲存到存檔熱鍵)轉換成`(定義按下用熱鍵)
    if(hotkeyname == "~") {
        hotkeyname := "``"
    }
    ;查找重複的熱鍵, 遍歷arr2d_tab1_AllLV_data第二欄和全重置HK, 有兩個以上一樣時不取消熱鍵
    for , row in arr2d_tab1_AllLV_data {
        if(row[2] == hotkeyname) {
            ++count_x
        }
    }
    if (arr_tab1_Other_Setting_data[1] == hotkeyname) {
            ++count_x
    }
    if (arr_tab1_Other_Setting_data[2] == hotkeyname) {
            ++count_x
    }
    if (arr_tab1_Other_Setting_data[3] == hotkeyname) {
            ++count_x
    }
    if(count_x >= 2) {
        return
    }
    if(hotkeyname == "~") {
        hotkeyname := "``"
    }
    try {
        hotkey "*~" hotkeyname,"OFF" ;停用舊的熱鍵
    }
    catch {
        msgbox "未註冊' " hotkeyname " '按鍵"
    }

}

main_start_countdown(presshotkeyname)
{
    global countdown_timer_is_running, float_countdown_step
    count_x := 1
    ;若設定開啟, 未找到活動視窗則return
    SetTitleMatchMode 2
    if (arr_tab1_Other_Setting_data[4] == 1 and WinActive(arr_tab1_Other_Setting_data[5]) == 0) {
        ;tooltip arr_tab1_Other_Setting_data[4] ":" WinActive(arr_tab1_Other_Setting_data[5])
        return
    }
    ;特別將`(定義熱鍵)轉換回~(儲存熱鍵)用於比較是否被按下
    if("*~``" == presshotkeyname or "~``" == presshotkeyname or "``" == presshotkeyname) {
        presshotkeyname := "*~~"
    }
    ;遍歷arr2d_tab1_AllLV_data的熱鍵欄資料
    for count_x, row in arr2d_tab1_AllLV_data {
        if("*~" row[2] == presshotkeyname or "~" row[2] == presshotkeyname or row[2] == presshotkeyname) {
            ;若設定開啟, 不重新執行CD中技能熱鍵
            if (arr_tab1_Other_Setting_data[6] == 1 and arr2d_tab1_AllLV_data[A_Index][4] > 0  and arr_tab1_timer_state[A_Index] > 0) {
                return
            }
            ;若非瞬發且有cd的技能歸類為type1
            if not (arr2d_tab1_AllLV_data[count_x][3] == 0 and arr2d_tab1_AllLV_data[count_x][4] > 0) {
                arr_tab1_timer_state[count_x] := 1 ;設定有該熱鍵的計時器狀態為1
                arr_tab1_timer_nowtime[count_x] := arr2d_tab1_AllLV_data[count_x][3] ;設定儲存的現在時間為儲存的技能持續時間
                local num_timer_nowtime := arr_tab1_timer_nowtime[count_x]
                try { ; 設定倒數時間回預設顏色 waitfix
                    arrobj_all_time_tab1_slot[count_x].SetFont("c" arr_tab1_FWin_Setting_data[9]) 
                    color_Fwin_time := arr_tab1_FWin_Setting_data[9]
                }
                catch {
                    arrobj_all_time_tab1_slot[count_x].SetFont("cdefault") ;設定倒數時間回預設顏色 waitfix
                    color_Fwin_time := "default"
                }
                ;arrobj_all_time_tab1_slot[count_x].Value := time_show_as_min(arr_tab1_timer_nowtime[count_x], arr_tab1_FWin_Setting_2_data[4]) ;設定計時器時間為儲存的現在時間
                ;change_back_time_width_tofit_time(count_x, arr_tab1_timer_nowtime[count_x], arr_tab1_FWin_Setting_data[7], arr_tab1_FWin_Setting_data[8], arr_tab1_FWin_Setting_data[5] + arr_tab1_FWin_Setting_data[6], arr_tab1_FWin_Setting_2_data[4])
                ;當sec小於顯示分鐘域值時顯示數字
                if(num_timer_nowtime <= arr_tab1_FWin_Setting_2_data[4]) { 
                    arrobj_all_time_tab1_slot[count_x].Value := num_timer_nowtime
                    if (arr_tab1_FWin_Setting_data[8] <= 5) { ;數字靠左
                        change_back_time_width_fit_sec_left(count_x, num_timer_nowtime, arr_tab1_FWin_Setting_data[7])
                    }
                    else { ;數字靠右
                        change_back_time_width_fit_sec_right(count_x, num_timer_nowtime, arr_tab1_FWin_Setting_data[7], arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5] + arr_tab1_FWin_Setting_data[6])
                    }
                }
                ;當sec大於於顯示分鐘域值時顯示分鐘
                else { 
                        local show_time_buffer := Floor(num_timer_nowtime/60) "m"
                        arrobj_all_time_tab1_slot[count_x].Value := show_time_buffer
                    if (arr_tab1_FWin_Setting_data[8] <= 5) { ;數字靠左
                        change_back_time_width_fit_min_left(count_x, num_timer_nowtime, arr_tab1_FWin_Setting_data[7])
                    }
                    else { ;數字靠右
                        change_back_time_width_fit_min_right(count_x, num_timer_nowtime, arr_tab1_FWin_Setting_data[7], arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5] + arr_tab1_FWin_Setting_data[6])
                    }                    
                }
                ;change_back_time_width_tofit_time(count_x, arr_tab1_timer_nowtime[count_x])
                if (arr_tab1_FWin_Setting_data[8] > 1) { ;當設定非時間不顯示時
                    arrobj_all_back_time_tab1_slot[count_x].Visible := true ;設定時間背景可見
                    arrobj_all_time_tab1_slot[count_x].Visible := true ;設定倒數時間可見
                }
                Pic_slot_visibility_SW(count_x, 1) ;設定彩色layer可見
            }
            ;若是瞬發且有cd的技能歸類為type2
            else {
                arr_tab1_timer_state[count_x] := 2 ;設定有該熱鍵的計時器狀態為2
                arr_tab1_timer_nowtime[count_x] := arr2d_tab1_AllLV_data[count_x][4] * - 1 + 1 - float_countdown_step  ;- arr_tab1_timer_nowtime[count_x]
                local num_Floored_timer_nowtime := Floor(arr_tab1_timer_nowtime[count_x])
                ;arrobj_all_time_tab1_slot[count_x].Value := time_show_as_min(Floor(num_timer_nowtime) * -1, arr_tab1_FWin_Setting_2_data[4]) ;設定計時器時間為儲存的現在時間
                ;change_back_time_width_tofit_time(count_x, (Floor(num_timer_nowtime) * -1), arr_tab1_FWin_Setting_data[7], arr_tab1_FWin_Setting_data[8], arr_tab1_FWin_Setting_data[5] + arr_tab1_FWin_Setting_data[6], arr_tab1_FWin_Setting_2_data[4])
                ;當sec小於顯示分鐘域值時顯示數字
                if(num_Floored_timer_nowtime <= arr_tab1_FWin_Setting_2_data[4]) { 
                    arrobj_all_time_tab1_slot[count_x].Value := num_Floored_timer_nowtime * -1
                    if (arr_tab1_FWin_Setting_data[8] <= 5) { ;數字靠左
                        change_back_time_width_fit_sec_left(count_x, num_Floored_timer_nowtime * -1, arr_tab1_FWin_Setting_data[7])
                    }
                    else { ;數字靠右
                        change_back_time_width_fit_sec_right(count_x, num_Floored_timer_nowtime * -1, arr_tab1_FWin_Setting_data[7], arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5] + arr_tab1_FWin_Setting_data[6])
                    }
                }
                ;當sec大於於顯示分鐘域值時顯示分鐘
                else { 
                        local show_time_buffer := Floor((num_Floored_timer_nowtime * -1)/60) "m"
                        arrobj_all_time_tab1_slot[count_x].Value := show_time_buffer
                    if (arr_tab1_FWin_Setting_data[8] <= 5) { ;數字靠左
                        change_back_time_width_fit_min_left(count_x, num_Floored_timer_nowtime * -1, arr_tab1_FWin_Setting_data[7])
                    }
                    else { ;數字靠右
                        change_back_time_width_fit_min_right(count_x, num_Floored_timer_nowtime * -1, arr_tab1_FWin_Setting_data[7], arr_tab1_FWin_Setting_data[5], arr_tab1_FWin_Setting_data[5] + arr_tab1_FWin_Setting_data[6])
                    }                    
                }
                ;hange_back_time_width_tofit_time(count_x, (Floor(arr_tab1_timer_nowtime[count_x]) * -1))
                if (arr_tab1_FWin_Setting_data[8] > 1) { ;當設定非時間不顯示時
                    arrobj_all_back_time_tab1_slot[count_x].Visible := true ;設定時間背景可見
                    arrobj_all_time_tab1_slot[count_x].Visible := true ;設定倒數時間可見
                }
                Pic_slot_visibility_SW(count_x, 0) ;設定黑白layer可見
                try { ; 設定color_Fwin_time的值
                    arrobj_all_time_tab1_slot[count_x].SetFont("c" arr_tab1_FWin_Setting_data[9]) 
                    color_Fwin_time := arr_tab1_FWin_Setting_data[9]
                }
                catch {
                    color_Fwin_time := "default"
                }
                arrobj_all_time_tab1_slot[count_x].SetFont("cAAAAAA") ;設定時間顏色為灰色
            }
        }
    }
    ;如果主timer不在運作, 啟動它
    if (countdown_timer_is_running == 0) {
        SetTimer(main_countdown_timer, num_countdown_timer_interval) ; 啟動主timer
        countdown_timer_is_running := 1 ; 將記錄主timer啟動變數設為1
        }
}
;arr2d_tab1_AllLV_data => 1-5>"名稱","按鍵","持續時間","冷卻時間","圖片位址",
;6-11>"end_SE_type","end_SE_pitch","end_AI_sec","CD_SE_type","CD_SE_pitch","CD_AI_sec"
main_countdown_timer() {
    global countdown_timer_is_running
    local show_time_buffer := ""
    count_x := 1
    count_y := 0 ;用來檢查有沒有timer正在執行
    local Time_Size := arr_tab1_FWin_Setting_data[7] ;取出時間大小存到變數中
    local Time_Location := arr_tab1_FWin_Setting_data[8] ;取出時間位置存到變數中
    if (Time_Location >= 6) {
        ;arr_tab1_FWin_Setting_data[5] := Num_Fwin_Pic_size1.Value, arr_tab1_FWin_Setting_data[6] := Num_Fwin_gap_of_Pic1.Value
        Pic_Size := arr_tab1_FWin_Setting_data[5]
        PicSizePlusGap := arr_tab1_FWin_Setting_data[5] + arr_tab1_FWin_Setting_data[6]
    }
    local SecToMinThreshold := arr_tab1_FWin_Setting_2_data[4] ;取出顯示分鐘臨界值存到變數中
    for count_x, value in arr_tab1_timer_state {
        if (arr_tab1_timer_state[count_x] >= 1) {
            count_y := 1
            ;倒數持續時間狀態
            if (arr_tab1_timer_nowtime[count_x] >= float_countdown_step) { 
                arr_tab1_timer_nowtime[count_x] -= float_countdown_step
                float_timer_nowtime := arr_tab1_timer_nowtime[count_x] ; 將陣列數值取出存到變數調用增加效能
                num_Floored_timer_nowtime := Floor(float_timer_nowtime)
                arr_now_AllLV_data := arr2d_tab1_AllLV_data[count_x] ; 將當前陣列行取出存到變數調用增加效能
                ;當這次時間sec和上次時間sec不同時變更GUI
                if(arr_tab1_last_showtime[count_x] != num_Floored_timer_nowtime) {
                    ;當sec小於顯示分鐘域值時顯示數字
                    if(num_Floored_timer_nowtime <= SecToMinThreshold) { 
                        ;儲存這次的時間sec用於下次比較
                        arr_tab1_last_showtime[count_x] := num_Floored_timer_nowtime 
                        arrobj_all_time_tab1_slot[count_x].Value := num_Floored_timer_nowtime
                        if (Time_Location <= 5) { ;數字靠左
                            change_back_time_width_fit_sec_left(count_x, num_Floored_timer_nowtime, Time_Size)
                        }
                        else { ;數字靠右
                            change_back_time_width_fit_sec_right(count_x, num_Floored_timer_nowtime, Time_Size, Pic_Size, PicSizePlusGap)
                        }
                    }
                    ;當sec大於於顯示分鐘域值時顯示分鐘
                    else { 
                        ;當這次時間min和上次時間min不同時變更GUI
                        if(Floor(arr_tab1_last_showtime[count_x]/60) != Floor(num_Floored_timer_nowtime/60)) {
                            ;儲存這次的時間sec用於下次比較
                            arr_tab1_last_showtime[count_x] := num_Floored_timer_nowtime 
                            show_time_buffer := Floor(num_Floored_timer_nowtime/60) "m"
                            arrobj_all_time_tab1_slot[count_x].Value := show_time_buffer
                            if (Time_Location <= 5) { ;數字靠左
                                change_back_time_width_fit_min_left(count_x, num_Floored_timer_nowtime, Time_Size)
                            }
                            else { ;數字靠右
                                change_back_time_width_fit_min_right(count_x, num_Floored_timer_nowtime, Time_Size, Pic_Size, PicSizePlusGap)
                            }
                        }                    
                    }
                }
                ;若nowtime == 提前秒數則撥放buff結束音效(含到0秒時的音效)
                if (arr_now_AllLV_data[8] == float_timer_nowtime) { 
                    paly_beep_sound(arr_now_AllLV_data[6], arr_now_AllLV_data[7])
                }
                ;小於10秒閃爍圖示, 當圖片在下半秒時為彩色, 上半秒時為黑白
                if (float_timer_nowtime <= 10) {
                    Pic_slot_visibility_SW(count_x, Mod(float_timer_nowtime, 1) < 0.5 ? 1 : 0)
                    ;當計時器歸0時檢查是否進入CD
                    if(float_timer_nowtime < float_countdown_step and arr_now_AllLV_data[4] > arr_now_AllLV_data[3]) {
                        ;設定計時器時間為剩餘冷卻時間=>儲存的持續時間減去技能冷卻時間
                        arr_tab1_timer_nowtime[count_x] := arr_now_AllLV_data[3] - arr_now_AllLV_data[4] - 1 + float_countdown_step ;- arr_tab1_timer_nowtime[count_x]
                        Pic_slot_visibility_SW(count_x, 0)
                        arrobj_all_time_tab1_slot[count_x].SetFont("cAAAAAA") ;設定時間顏色為灰色
                    }
                }
            }
            ;倒數CD狀態
            else if (arr_tab1_timer_nowtime[count_x] <= float_countdown_step * -1) {
                arr_tab1_timer_nowtime[count_x] += float_countdown_step
                float_timer_nowtime := arr_tab1_timer_nowtime[count_x] ;將陣列數值取出存到常數調用增加效能
                num_Floored_timer_nowtime := Floor(float_timer_nowtime)
                arr_now_AllLV_data := arr2d_tab1_AllLV_data[count_x] ; 將當前陣列行取出存到變數調用增加效能
                if(arr_tab1_last_showtime[count_x] != num_Floored_timer_nowtime) {
                    arr_tab1_last_showtime[count_x] := num_Floored_timer_nowtime
                    ;當sec小於顯示分鐘域值時顯示數字
                    if(num_Floored_timer_nowtime <= SecToMinThreshold) { 
                        arrobj_all_time_tab1_slot[count_x].Value := num_Floored_timer_nowtime * -1
                        if (Time_Location <= 5) { ;數字靠左
                            change_back_time_width_fit_sec_left(count_x, num_Floored_timer_nowtime * -1, Time_Size)
                        }
                        else { ;數字靠右
                            change_back_time_width_fit_sec_right(count_x, num_Floored_timer_nowtime * -1, Time_Size, Pic_Size, PicSizePlusGap)
                        }
                    }
                    ;當sec大於於顯示分鐘域值時顯示分鐘
                    else { 
                        show_time_buffer := Floor((num_Floored_timer_nowtime * -1)/60) "m"
                        arrobj_all_time_tab1_slot[count_x].Value := show_time_buffer
                        if (Time_Location <= 5) { ;數字靠左
                            change_back_time_width_fit_min_left(count_x, num_Floored_timer_nowtime * -1, Time_Size)
                        }
                        else { ;數字靠右
                            change_back_time_width_fit_min_right(count_x, num_Floored_timer_nowtime * -1, Time_Size, Pic_Size, PicSizePlusGap)
                        }                         
                    }
                }
                ;若nowtime == 提前秒數則撥放CD結束音效(含到0秒時的音效)
                if (arr_now_AllLV_data[11] == (float_timer_nowtime * -1) ) { 
                    paly_beep_sound(arr_now_AllLV_data[9], arr_now_AllLV_data[10])
                }
            }
            ;倒數歸0狀態
            else {
                arr_tab1_timer_state[count_x] := 0 ; 重置該計時器的運行狀態為0
                arr_tab1_timer_nowtime[count_x] := 0 ; 將計時器的儲存時間設為0
                arrobj_all_time_tab1_slot[count_x].Value := 0 ; 將倒數時間GUI的時間設為0
                arrobj_all_back_time_tab1_slot[count_x].Visible := false ;設定時間背景GUI不可見
                arrobj_all_time_tab1_slot[count_x].Visible := false ;設定倒數時間GUI不可見
                ; 設定倒數時間回預設顏色 waitfix
                arrobj_all_time_tab1_slot[count_x].SetFont("c" color_Fwin_time) 
                ; 根據CD時間顯示彩色或黑白圖片
                Pic_slot_visibility_SW(count_x, arr2d_tab1_AllLV_data[count_x][4] == 0 ? 0 : 1)
            }
        }
    }
    if (count_y == 0) {
        ;ToolTip "no_timer_now"
        countdown_timer_is_running := 0
        SetTimer(main_countdown_timer, 0)
    }
}

stop_all_countdown(*) {
    global countdown_timer_is_running
    local count_x := 1
    ;若設定開啟, 未找到活動視窗則return
    SetTitleMatchMode 2
    if (arr_tab1_Other_Setting_data[4] == 1 and WinActive(arr_tab1_Other_Setting_data[5]) == 0) {
        ;tooltip arr_tab1_Other_Setting_data[4] ":" WinActive(arr_tab1_Other_Setting_data[5])
        return
    }
    SetTimer(main_countdown_timer, 0)
    countdown_timer_is_running := 0
    for count_x, value in arr_tab1_timer_state {
        arr_tab1_timer_state[count_x] := 0 ; 重置該計時器的運行狀態為0
        arr_tab1_timer_nowtime[count_x] := 0 ; 將計時器的儲存時間設為0
        arrobj_all_time_tab1_slot[count_x].Value := 0
        arrobj_all_back_time_tab1_slot[count_x].Visible := false ;設定時間背景不可見
        arrobj_all_time_tab1_slot[count_x].Visible := false ;設定倒數時間不可見
        ;waitfix
        try {
            arrobj_all_time_tab1_slot[count_x].SetFont("c" CBB_Fwin_Time_num_color1.text) ;設定倒數時間回預設顏色 waitfix
        }
        catch {
        arrobj_all_time_tab1_slot[count_x].SetFont("cdefault") ;設定倒數時間回預設顏色 waitfix
        }
        if (arr2d_tab1_AllLV_data[count_x][4] == 0) {
            Pic_slot_visibility_SW(count_x, 0)
        }
        else {
            Pic_slot_visibility_SW(count_x, 1)
        }
    }
}

stop_all_countdown_for_SL(*) {
    global countdown_timer_is_running
    local count_x := 1
    ;若設定開啟, 未找到活動視窗則return
    SetTimer(main_countdown_timer, 0)
    countdown_timer_is_running := 0
    for count_x, value in arr_tab1_timer_state {
        arr_tab1_timer_state[count_x] := 0 ; 重置該計時器的運行狀態為0
        arr_tab1_timer_nowtime[count_x] := 0 ; 將計時器的儲存時間設為0
        arrobj_all_time_tab1_slot[count_x].Value := 0
        arrobj_all_back_time_tab1_slot[count_x].Visible := false ;設定時間背景不可見
        arrobj_all_time_tab1_slot[count_x].Visible := false ;設定倒數時間不可見
        ;waitfix
        try {
            arrobj_all_time_tab1_slot[count_x].SetFont("c" CBB_Fwin_Time_num_color1.text) ;設定倒數時間回預設顏色 waitfix
        }
        catch {
        arrobj_all_time_tab1_slot[count_x].SetFont("cdefault") ;設定倒數時間回預設顏色 waitfix
        }
        if (arr2d_tab1_AllLV_data[count_x][4] == 0) {
            Pic_slot_visibility_SW(count_x, 0)
        }
        else {
            Pic_slot_visibility_SW(count_x, 1)
        }
    }
}

time_show_as_min(sec, SecToMinThreshold) {
    if(sec > SecToMinThreshold) {
        return Floor(sec/60) "m"
    }
    else {
        return sec
    }
}

change_back_time_width_fit_sec_left(slotindex, sec, Time_Size) {
    ;當sec為1位數
    if(sec < 10) {
        arrobj_all_back_time_tab1_slot[slotindex].Move( , , Time_Size * 0.9, )
    } 
    ;當sec為2位數
    else if (sec < 100) {
        arrobj_all_back_time_tab1_slot[slotindex].Move( , , Time_Size * 1.7, )
    }
    ;當sec為3位數
    else if (sec < 1000) {
        arrobj_all_back_time_tab1_slot[slotindex].Move( , , Time_Size * 2.4, )
    }
    ;當sec為4位數
    else if (sec < 10000) {
        arrobj_all_back_time_tab1_slot[slotindex].Move( , , Time_Size * 3.1, )
    }
    else {
        arrobj_all_back_time_tab1_slot[slotindex].Move( , , Time_Size * 3.8, )
    }
}

change_back_time_width_fit_min_left(slotindex, sec, Time_Size) {
    ;當min為1位數
    if(sec < 60) {
        arrobj_all_back_time_tab1_slot[slotindex].Move( , , Time_Size * 1.3, )
    } 
    ;當min為2位數
    else if (sec < 600) {
        arrobj_all_back_time_tab1_slot[slotindex].Move( , , Time_Size * 2.1, )
    }
    ;當min為3位數
    else if (sec < 6000) {
        arrobj_all_back_time_tab1_slot[slotindex].Move( , , Time_Size * 2.9, )
    }
    ;當min為4位數
    else if (sec < 60000) {
        arrobj_all_back_time_tab1_slot[slotindex].Move( , , Time_Size * 3.6, )
    }
    else {
        arrobj_all_back_time_tab1_slot[slotindex].Move( , , Time_Size * 4.3, )
    }
}

change_back_time_width_fit_sec_right(slotindex, sec, Time_Size, Pic_size, PicSizePlusGap) {
    ;當sec為1位數
    local back_time_basic_location_x := 25 + slotindex * PicSizePlusGap - floor(Pic_size / 16) + floor(Time_Size / 10)
    if(sec < 10) {
        local Time_Size_scaled := Time_Size * 0.9
    } 
    ;當sec為2位數
    else if (sec < 100) {
        local Time_Size_scaled := Time_Size * 1.7
    }
    ;當sec為3位數
    else if (sec < 1000) {
        local Time_Size_scaled := Time_Size * 2.4
    }
    ;當sec為4位數
    else if (sec < 10000) {
        local Time_Size_scaled := Time_Size * 3.1 
    }
    else {
        local Time_Size_scaled := Time_Size * 3.8
    }
    if (Time_Size_scaled < PicSizePlusGap) {
        arrobj_all_back_time_tab1_slot[slotindex].Move( back_time_basic_location_x - Time_Size_scaled, , Time_Size_scaled, )
    }
    else {
        arrobj_all_back_time_tab1_slot[slotindex].Move( back_time_basic_location_x - PicSizePlusGap, , PicSizePlusGap, )
    }
}

change_back_time_width_fit_min_right(slotindex, sec, Time_Size, Pic_size, PicSizePlusGap) {
    local back_time_basic_location_x := 25 + slotindex * PicSizePlusGap - floor(Pic_size / 16) + floor(Time_Size / 10)
    ;當min為1位數
    if(sec < 60) {
        local Time_Size_scaled := Time_Size * 1.3
    } 
    ;當min為2位數
    else if (sec < 600) {
        local Time_Size_scaled := Time_Size * 2.1
    }
    ;當min為3位數
    else if (sec < 6000) {
        local Time_Size_scaled := Time_Size * 2.9
    }
    ;當min為4位數
    else if (sec < 60000) {
        local Time_Size_scaled := Time_Size * 3.6
    }
    else {
        local Time_Size_scaled := Time_Size * 4.3
    }
    if (Time_Size_scaled < PicSizePlusGap) {
        arrobj_all_back_time_tab1_slot[slotindex].Move( back_time_basic_location_x - Time_Size_scaled, , Time_Size_scaled, )
    }
    else {
        arrobj_all_back_time_tab1_slot[slotindex].Move( back_time_basic_location_x - PicSizePlusGap, , PicSizePlusGap, )
    }
}


Pic_slot_visibility_SW(slotindex, state) {

    if(state == 0) {
    arrobj_all_Pic_child_tab1_slot[slotindex].Visible := true
    arrobj_all_Pic_tab1_slot[slotindex].Visible := false
    }
    else {
    arrobj_all_Pic_tab1_slot[slotindex].Visible := true
    arrobj_all_Pic_child_tab1_slot[slotindex].Visible := false
    }
}

show_data_arry(*) {
str_for_show := ""
x_var1 := 1
y_var1 := 1
for y_var1, row in arr2d_tab1_AllLV_data {
    for x_var1, value in row {
        str_for_show := str_for_show " [ " arr2d_tab1_AllLV_data[y_var1][x_var1] " ] ."
    }
        str_for_show := str_for_show "`n"
    ++y_var1
}
MsgBox str_for_show
}

show_data_arry_2(*) {
    str_for_show := ""

    str_for_show := "arr_tab1_FWin_Setting_data：`n"
    for value in arr_tab1_FWin_Setting_data {
        str_for_show := str_for_show " [ " value " ] ."
    }

    str_for_show := str_for_show "`arr_tab1_FWin_Setting_2_data`n"
    for value in arr_tab1_FWin_Setting_2_data {
        str_for_show := str_for_show " [ " value " ] ."
    }

    str_for_show := str_for_show "`narr_tab1_Other_Setting_data：`n"
    for value in arr_tab1_Other_Setting_data {
        str_for_show := str_for_show " [ " value " ] ."
    }

    str_for_show := str_for_show "`narr_tab1_last_closed_Setting：`n"
    for value in arr_tab1_last_closed_Setting {
        str_for_show := str_for_show " [ " value " ] ."
    }

    str_for_show := str_for_show "`narr_tab1_each_buff_setting_path：`n"
    for value in arr_tab1_each_buff_setting_path {
        str_for_show := str_for_show " [ " value " ] ."
    }

    MsgBox str_for_show
}

MainGui_show_Switch(*) {
    global MainGui_show_state
    If(MainGui_show_state == 0)
        {
        ;MainGui.Show("AutoSize")
        ;WinGetPos(,, &MainGui_W,&MainGui_H, "ahk_id " MainGui.Hwnd)
        ;MainGui.move(,,MainGui_W-14,MainGui_H-5)
        MainGui.show("w" 653 " h" 568)
        Maingui_show_state := 1
        return
    }
    Else {
        MainGui.hide()
        MainGui_show_state := 0
        return
    }
}

Fwin_show_Switch(*) {
    global Fwin_show_state
    If(Bool_FWin_SW1.Value)
        {
        FWin_W :=25 + (arr_tab1_FWin_Setting_data[5] + arr_tab1_FWin_Setting_data[6]) * 10
        FWin_H :=(9 + arr_tab1_FWin_Setting_data[5] + arr_tab1_FWin_Setting_data[7] * 1.5)
        FWinGui_base.Show("x" Num_FWin_now_Xaxis.Value "y" Num_FWin_now_Yaxis.Value "w" FWin_W " h" FWin_H)
        ;FWinGui_layer1.Show("x" Num_FWin_now_Xaxis.Value "y" Num_FWin_now_Yaxis.Value "AutoSize")
        Fwin_show_state := 1
        btn_quick_hide_Fwin.Visible := true
        btn_quick_show_Fwin.Visible := false
    }
    Else {
        FWinGui_base.hide()
        Fwin_show_state := 0
        btn_quick_show_Fwin.Visible := true
        btn_quick_hide_Fwin.Visible := false
        ;FWinGui_layer1.hide()
    }

}

Fwin_quick_show_Switch(*) {
    global Fwin_show_state
    If(Fwin_show_state == 0)
        {
        FWin_W :=25 + (arr_tab1_FWin_Setting_data[5] + arr_tab1_FWin_Setting_data[6]) * 10
        FWin_H :=(9 + arr_tab1_FWin_Setting_data[5] + arr_tab1_FWin_Setting_data[7] * 1.5)
        FWinGui_base.Show("x" Num_FWin_now_Xaxis.Value "y" Num_FWin_now_Yaxis.Value "w" FWin_W " h" FWin_H)
        ;FWinGui_layer1.Show("x" Num_FWin_now_Xaxis.Value "y" Num_FWin_now_Yaxis.Value "AutoSize")
        Fwin_show_state := 1
        btn_quick_hide_Fwin.Visible := true
        btn_quick_show_Fwin.Visible := false
    }
    Else {
        FWinGui_base.hide()
        Fwin_show_state := 0
        btn_quick_show_Fwin.Visible := true
        btn_quick_hide_Fwin.Visible := false
        ;FWinGui_layer1.hide()
    }

}

Fwin_text_color_changed(change_color_obj,change_part,color_code,tip_mode?,Ctrl?,item?) {
    if(color_code == "") {
        return false
    }
    if(color_code == "不顯示" or color_code == "non") {
    ; change_color_obj.Visible := false
        change_color_obj.Opt("Background" "")
        change_color_obj.Visible := !change_color_obj.Visible
        change_color_obj.Visible := !change_color_obj.Visible
        return true
    }
    try {
        if (change_part == 1 or change_part == "num") {
            change_color_obj.SetFont("c" color_code)
        }
        else if (change_part == 2 or change_part == "back") {
            change_color_obj.Opt("Background" color_code)
        }
    }
    catch {
        switch tip_mode, 0 {
            case 0 :
            case 1 :
                Show_ToolTip("<= 可用色碼：000000~FFFFFF", 5, -25, CBB_Fwin_Time_num_color1)
                return false
            case 2 :
                Show_ToolTip("<= 可用色碼：000000~FFFFFF", 5, -25, CBB_Fwin_Time_back_color1)
                return false
            default:
            }
    }
    change_color_obj.Visible := !change_color_obj.Visible
    change_color_obj.Visible := !change_color_obj.Visible
    return true
}

FWin_Location_lock(*)
{    ;WS_EX_CLICKTHROUGH Style：+E0x20選項讓滑鼠的點擊穿過GUI
    if(Bool_lock_FWin.Value) {
        FWinGui_base.Opt("+E0x20")
        FWinGui_layer1.Opt("+E0x20")
        FWinGui_layer2.Opt("+E0x20")
        FWinGui_layer3.Opt("+E0x20")
        FWinGui_base.Move(Num_FWin_now_Xaxis.Value, Num_FWin_now_Yaxis.Value)
        pic_move_arrow.Visible := false
        Bool_move_FWin.Value := 0
    } 
    else {
        Bool_move_FWin.Value := 1
    }
}

FWin_Location_unlock(*) {
    if(Bool_move_FWin.Value) {
        FWinGui_base.Opt("-E0x20")
        FWinGui_layer1.Opt("-E0x20")
        FWinGui_layer2.Opt("-E0x20")
        FWinGui_layer3.Opt("-E0x20")            
        pic_move_arrow.Visible := true
        Bool_lock_FWin.Value := 0
    } 
    else {
        Bool_lock_FWin.Value := 1
    }
}

WM_Letguidraggable(wParam, lParam, msg, hwnd)
{
    ;  if (hwnd = FWinGui_base.Hwnd) {
    ;  PostMessage(0xA1, 2,,, FWinGui_base)
    ;  }
    ; if (hwnd = Pic_child_tab1_slot2.Hwnd) {
    ; PostMessage(0xA1, 2,,, FWinGui_layer1.Hwnd)
    ; }
    if (hwnd = FWinGui_base.Hwnd) {
    PostMessage(0xA1, 2,,, FWinGui_base.Hwnd)
    }
    ; if (hwnd = FWinGui_layer2.Hwnd) {
    ; PostMessage(0xA1, 2,,, FWinGui_layer1)
    ; }
}

WM_getguimoved(wParam, lParam, msg, hwnd) {
    ; 透過 WinGetPos 取得 GUI 的目前位置與大小
    if (WinExist("ahk_id " FWinGui_base.Hwnd)) {
        WinGetPos(&Pos_x1, &Pos_y1, &Pos_w1, &Pos_h1, "ahk_id " FWinGui_base.Hwnd)
        Num_FWin_now_Xaxis.Value := Pos_x1
        Num_FWin_now_Yaxis.Value := Pos_y1
        FWin_setting_unsafed_check()
    }
    if (WinExist("ahk_id " MainGui.Hwnd)) {
        WinGetPos(&Pos_x2, &Pos_y2, &Pos_w2, &Pos_h2, "ahk_id " MainGui.Hwnd)
        arr_tab1_last_closed_Setting[2] := Pos_x2
        arr_tab1_last_closed_Setting[3] := Pos_y2
        save_into_ini(arr_tab1_last_closed_Setting, "arr_tab1_last_closed_Setting", 1,, A_ScriptDir "\setting_files\General_Settings.ini")
    }
}
