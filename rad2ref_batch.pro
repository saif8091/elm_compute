PRO rad2ref_batch;, cal_file, rad_path, output_file_path
  ;Script for converting to reflectance from radiance using ELM. 
  ;First you need to compute the factors by using the toolbox then use this code for batch processing
  ;cal_file: specify the callibration file (.cff) 
  ;rad_path: specify the directory of the radiance files
  ;output_file_path: specify the directory of the reflectance files
  ;you can change the format of the output files to either 'Envi' of 'tif'
  
  COMPILE_OPT IDL2
  format = 'Envi'
  cal_file = 'S:\ms4667\Geneva Beets 2021\20210802_5th\Nano\cal_panel_tie_points\cal_5th_flight_4_point.cff'
  rad_path = 'S:\ms4667\Geneva Beets 2021\20210802_5th\Nano\New folder\'
  output_file_path = 'S:\ms4667\Geneva Beets 2021\20210802_5th\Nano\sp_cor_reflectance\'
  
  
  rad_files = FILE_SEARCH(rad_path+'*.hdr')
  
  cal = READ_ASCII(cal_file, DATA_START=5) ;Read from the callibration file skipping the values containing comments
  a = REFORM(cal.(0)[1,*])
  b = REFORM(cal.(0)[2,*])
  n_bands = SIZE(a,/N_ELEMENTS)
  gains = 1/a
  offsets = -b/a
  Threshold_Min = FLTARR(n_bands)
  
  e = ENVI(/HEADLESS) ;use headless when you do not want to open envi
  
  n_files=n_elements(rad_files)
  FOR i=0,n_files-1 DO BEGIN
  
    ;file manipulation code
    File = rad_files[i]
    fp = output_file_path+strmid(File,strlen(rad_path))
    out_file = strmid(fp,0,strlen(fp)-4)+'_ref'
    
    PRINT, 'Completed: ', STRTRIM(i,1), ' from ',STRTRIM(n_files,1)
    
    ;reflectance conversion
    Raster = e.OpenRaster(File)
    ref = ENVIGainOffsetWithThresholdRaster(Raster, gains, offsets, $
      THRESHOLD_MINIMUM=Threshold_Min, DATA_TYPE = 'float')
  
    if (format eq 'tiff') OR (format eq 'tif') Then out_file = out_file+'.tif'
    ref.Export, out_file, format
  ENDFOR
  e.close
  PRINT, 'Conversion completed!!!'
END