# About
This script converts multiple ENVI files from radiance to reflectance using the Empirical Line Method (ELM).

## Instructions

1. **Compute Factors**:
   - Use the toolbox to compute the necessary factors for conversion.

2. **Run the Script**:
   - Ensure you have the following inputs ready:
     - `cal_file`: Path to the calibration file (.cff).
     - `rad_path`: Directory containing the radiance files.
     - `output_file_path`: Directory where the reflectance files will be saved.
     - `format`: Desired format for the output files, either 'Envi' or 'tif'.

3. **Example Usage**:
   - Update the script with your specific paths and format:
     ```pro
     cal_file = 'path/to/your/calibration_file.cff'
     rad_path = 'path/to/your/radiance_files/'
     output_file_path = 'path/to/your/output_directory/'
     format = 'Envi'  ; or 'tif'
     ```

4. **Run the Script**:
   - Execute the script to start the batch processing.

## Notes
- The script reads the calibration file, processes each radiance file, and saves the converted reflectance files in the specified output directory.
- Ensure the paths and file formats are correctly specified to avoid errors during execution.