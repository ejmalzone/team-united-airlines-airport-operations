# HOW TO USE

1.  Hosting Database/API Endpoints:
    1.  Included within the deliverables are all required files for the API and database.
    2.  Using AWS EC2:
        1.  Create EC2 Instance using Amazon Linux Image, desired Key Pair and Security Group
        2.  Ensure that the security group will allow for HTTP/HTTPS requests to be made, depending on desired setup. Security group could be set to accept all traffic, accept traffic from specific IPs, etc.
        3.  NOTE: If planning to host the web application online, EC2 instance must be configured to use SSL/TLS
            1.  <https://docs.aws.amazon.com/cloudhsm/latest/userguide/third-offload-linux-openssl.html>
            2.  Flutter web is heavily in Beta, and as such, local running is advised/preferred for performance, alleviating the necessity for SSL/TLS on the EC2 instance
        4.  Connect to EC2 Instance via preferred method, and upload Database/API files
        5.  If not already installed, install node via: \$ sudo yum install -y nodejs
        6.  From within the same directory as package.json: \$ npm install
        7.  Create a new TMUX instance using the following command:
            1.  \$ tmux new -s api
            2.  Ctrl + b
            3.  d
            4.  \$ tmux ls \# This is LS, not iS
                1.  The above command should show the newly created “api” tmux instance
        8.  Connect to the “api” tmux instance via: \$ tmux a -t api
        9.  Change to the “team-united-airlines-airport-operations-api-main” directory
        10. Packaged in the API documents is a shell script called “install-prereqs.sh”. This script will download docker and anything that is necessary to deploy the server. Permissions will need to be set for the script to execute, which can be done by typing “chmod +rwx install-prereqs.sh”. Running the script can be done by typing “./install-prereqs.sh”.
        11. Option 1 for starting: After running the prereqs script, simply type in “docker-compose up” and the server will start with a mongodb database attached to port 27017 and the API attached to port 5000. To change the API port, edit the value “API_PORT” in the script “index.js”.
        12. Option 2: type “chmod +rwx install-and-start.sh” to give install-and-start execution permissions, then run it by typing “./install-and-start.sh”. This will both install docker and automatically run “docker-compose up”.
        13. Ctrl + b -\> d to exit the TMUX instance
        14. The API is now actively running within a Docker container.
        15. To update the API endpoint URL in the flutter code:
            1.  Open the project file “database.dart” in any editor
            2.  Change the baseURL variable on line 10 to be your EC2 instance’s public IPv4 DNS with ‘/api/’ appended to the end  
                ![](media/6e20440800b4422804fe1d36cbe0dbed.png)
            3.  Your baseURL should look something like: ‘http:// ec2-52-3-243-69.compute-1.amazonaws.com/api/’
2.  Installation options:
    1.  Note: Flutter must be installed from <https://docs.flutter.dev/get-started/install>
    2.  Run "initialize.bat"
    3.  Android
        1.  Run the file “build_android.bat”
        2.  The .apk file will be located under /build/app/outputs/flutter-apk/app-release.apk
        3.  This file may be installed on Honeywell Scanners as well as most Android devices.
    4.  iOS
        1.  <https://docs.flutter.dev/deployment/ios>
        2.  Follow flutter documentation for installation/hosting on app store
        3.  Apple does not allow for the installation of an application in the way that android does with .apk files.
    5.  Web
        1.  Flutter Web is still in Beta, and due to this, Flutter web apps perform somewhat poorly when hosted. With this being the case, web hosting is still possible, but running the app locally will perform far better.
        2.  To run locally:
            1.  Run the provided file, build_web_and_run.bat
            2.  If prompted, press the number corresponding to the desired browser
        3.  If desired, the web application may be hosted through github pages, AWS S3 buckets, or another comparable host, but the application must run via an HTTPS page for the camera functionalities to work. As a result, the API must be hosted via an HTTPS endpoint, and all of the requests from within the application must also be converted to be HTTPS requests.
            1.  For setting up an EC2 instance using SSL/TLS, consult the following tutorial:
                1.  <https://docs.aws.amazon.com/cloudhsm/latest/userguide/third-offload-linux-openssl.html>
        4.  Local hosting of the web-app for access via mobile device is possible, but will also require EC2 TLS/SSL configuration, and may not behave as intended due to platform differences. To locally host the web-app via HTTPS, run "create_cert.py", and this will generate a file named "cert.pem". Build the application for web, put cert.pem and host_server.py in the /build/web directory, and in a terminal window, "python host_server.py" will host the server locally. https://{server_host_address}:4443 will allow access to the web app, but logins and other functionality will not function without TLS/SSL support. 
    6.  Windows:
        1.  Run “build_windows.bat” to generate windows files, program can be safely exited once it has run once
        2.  Program files can be found in /build/windows/runner/Debug
        3.  To distribute the windows application, ensure that the “data” folder as well as all other files in the Debug directory are distributed alongside the airportops_frontend.exe application
        4.  Note: Debug version is used instead of release due to Flutter bugs, Release builds of windows will typically run one time and then be unable to be re-opened due to a bug in Flutter. The debug build is essentially the same as release, with some additional error handling.
3.  Initial Login
    1.  The default username and password of “admin” (this can be changed through modification of the API/Database code) will allow login to the admin portal, and from this point further admins may be created.
    2.  To create an event, select the “New Event” button, enter the desired name, and select whether or not the event should have randomized data.
    3.  Click on either “View Event”, or the arrow on the event card, to enter the event. If it is not already the current event, which is indicated by the main admin screen, press “Set Current Event” from within the desired event.
    4.  Competitors may register through the Customer Service and Ramp Service pages of the application, and will automatically be added to the event upon creation.
    5.  New passengers and bags may be added on the corresponding screens of an event.
    6.  When the desired passengers/bags have been created, the button at the bottom of the screen will allow for the printing of boarding passes and baggage tags.
    7.  The third tab of each event shows current competitors. Clicking on the competitors shows what they have scanned. Clicking on the passengers/bags that they have scanned will show when they were scanned.
    8.  The final tab of each event shows metrics for each competitor.
