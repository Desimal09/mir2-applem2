// 客户端设置
unit ClientSetup;

interface

uses
  Share;

const
  FILE_NAME = '.\randall.ini';
  MIR2_SETUP_SECTION = 'Mir2Setup';
  BIT_DEPTH_KEY = 'BitDepth';
  DISPLAY_SIZE_KEY = 'DisplaySize';
  MUSIC_VOLUME_KEY = 'MusicVolume';
  SOUND_VOLUME_KEY = 'SoundVolume';
  MUSIC_OPEN_KEY = 'MusicOpen';
  SOUND_OPEN_KEY = 'SoundOpen';

var
  fileLocked: Boolean = False;

  procedure loadData();

  procedure saveData();

implementation

uses IniFiles;

procedure loadData();
var
  iniFile: TIniFile;
  bitDepth: Boolean;
begin
  iniFile := TIniFile.Create(FILE_NAME);
  // true 表示 32 位颜色，否则是 16 位颜色
  bitDepth := True;
  try
    if iniFile <> nil then
    begin
      bitDepth := iniFile.ReadBool(MIR2_SETUP_SECTION, BIT_DEPTH_KEY, bitDepth);
      g_FScreenMode := iniFile.ReadInteger(MIR2_SETUP_SECTION, DISPLAY_SIZE_KEY, g_FScreenMode);
      g_btMP3Volume := iniFile.ReadInteger(MIR2_SETUP_SECTION, MUSIC_VOLUME_KEY, g_btMP3Volume);
      g_btSoundVolume := iniFile.ReadInteger(MIR2_SETUP_SECTION, SOUND_VOLUME_KEY, g_btSoundVolume);
      g_boBGSound := iniFile.ReadBool(MIR2_SETUP_SECTION, MUSIC_OPEN_KEY, g_boBGSound);
      g_boSound := iniFile.ReadBool(MIR2_SETUP_SECTION, SOUND_OPEN_KEY, g_boSound);
      if bitDepth then g_BitCount := 32 else g_BitCount := 16;
    end;
  finally
    if iniFile <> nil then
    begin
      iniFile.Free;
    end;
  end;
end;

procedure saveData();
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(FILE_NAME);
  Try
    if ini <> nil then
    begin
      ini.WriteBool(MIR2_SETUP_SECTION, BIT_DEPTH_KEY, g_BitCount = 32);
      ini.WriteInteger(MIR2_SETUP_SECTION, DISPLAY_SIZE_KEY, g_FScreenMode);
      ini.WriteInteger(MIR2_SETUP_SECTION, MUSIC_VOLUME_KEY, g_btMP3Volume);
      ini.WriteInteger(MIR2_SETUP_SECTION, SOUND_VOLUME_KEY, g_btSoundVolume);
      ini.WriteBool(MIR2_SETUP_SECTION, MUSIC_OPEN_KEY, g_boBGSound);
      ini.WriteBool(MIR2_SETUP_SECTION, SOUND_OPEN_KEY, g_boSound);
    end;
  Finally
    if ini <> nil then
    begin
      ini.Free;
    end;
  End;
end;

end.