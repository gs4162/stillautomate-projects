# Automate Camera Photo Import

This PowerShell script automates the process of importing photos from a Canon EOS camera using Windows Task Scheduler. The script can also be adapted for other devices, such as Android phones or other models of cameras.

## How to Use

1. **Download the Script**

    There are two options for obtaining the script:
    
    - **Clone the repository:** If you're familiar with Git, you can clone the repository containing the script from GitHub. You'll need Git installed on your system.
    
    - **Download the script directly:** If you don't use Git, you can download the `ImportPhotos.ps1` file directly from GitHub.

2. **Set Up the Folder Structure**

    Create a folder where you want to import your photos. For example, you could create a folder on your desktop named "ImportedPhotos".

3. **Modify the Script**

    Open the `ImportPhotos.ps1` file in a text editor. Update the following paths to reflect your specific setup:
    
    - `$sourcePath`: Replace this path with the location where your camera stores photos. For example, on a Canon camera, it might be `E:\DCIM\100CANON`.
    
    - `$destinationPath`: Replace this path with the folder you created in step 2 (e.g., `C:\Users\YourUsername\Desktop\ImportedPhotos`).

4. **Create a Task in Task Scheduler**

    Refer to a separate resource, such as a YouTube video, for instructions on creating a new task in Windows Task Scheduler. Configure the task to trigger the `ImportPhotos.ps1` script when your camera is connected.

5. **Run the Script**

    Connect your camera to your computer. The Task Scheduler should automatically run the script to import your photos. Alternatively, you can run the script manually from within PowerShell to test its functionality.

6. **Adapting for Other Devices**

    This script can be adapted for other devices by modifying the `$sourcePath` variable to match the path where your device stores photos.

7. **Issues and Contributions**

    If you encounter any problems with the script or have suggestions for improvement, you can find more information about reporting issues and contributing to the project on the GitHub repository.

8. **License**

    This project is licensed under the MIT License.

For more information, connect with me on [LinkedIn](https://www.linkedin.com/in/grayson-stillwell-211a8a69/) and check out my YouTube channel [StillAutomate](https://www.youtube.com/@stillautomate-my5gh).
