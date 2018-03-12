# kssh
Massive ssh tools based on konsole (KDE) profiles

# To install it

**Requirement:**
- bash
- konsole 16.12 or higher

1. install kssh

    ```bash
    $ ./install.sh
    ```

2. Use it

    ```bash
    $ kssh
    ```

Chrisssss

# Usage

**Test Connection**

This feature has been added to be able to check the status of the connection with the servers in a simple way. It works for servers where typing the password is not required. For example, in those where you have already sent your public RSA key and you do not need to type your password every time you login.

So suppose you have the following list of servers added to the KSSH:

    ```bash
    $ kssh --m "SRV.*\(test\)"
    server1.test.com
    server2.test.com
    server3.test.com
    server4.test.com
    server5.test.com
    server6.test.com
    server7.test.com
    server8.test.com
    server9.test.com
    server10.test.com
    ```

In all these servers you do not need to be typing your password since you have sent each of them your RSA public key. To check that you have your user properly configured, type the following command:

    ```bash
    $ kssh "SRV.*\(test\)"
    user@server1.test.com
    user@server2.test.com
    user@server3.test.com
    user@server4.test.com
    user@server5.test.com
    user@server6.test.com
    user@server7.test.com
    user@server8.test.com
    user@server9.test.com
    user@server10.test.com
    ```

Now a list has been displayed with the same servers but with your username. If you just want to check that you can connect to all these servers then type the following command:

    ```bash
    $ KSSH_TEST_CMD="ssh" kssh "SRV.*\(test\)"
    [ FAIL ] user@server1.test.com
    [  OK  ] user@server2.test.com
    [  OK  ] user@server3.test.com
    [ FAIL ] user@server4.test.com
    [  OK  ] user@server5.test.com
    [  OK  ] user@server6.test.com
    [ FAIL ] user@server7.test.com
    [  OK  ] user@server8.test.com
    [ FAIL ] user@server9.test.com
    [  OK  ] user@server10.test.com

    OK:       5
    Fail:     5
    Warning:  0
             --
             10
    ```

As you can see, there is now an indicator before each server which indicates the state of connectivity. The indicators will appear in color to make it easy to detect a problem. There are three indicators:

    ```bash
    [  OK  ] A successful connection was established
    [ FAIL ] There was a problem trying to establish the connection
    [ WARN ] This indicator appears when we try to execute a remote command and an error occurs.
    ```

The environment variable **KSSH_TEST_CMD** will help us determine what we want to test. For example, if we want to know if the **user** can execute the **ls -la** command then we type the following:

    ```bash
    $ KSSH_TEST_CMD="/usr/bin/ls -la &" kssh "SRV.*\(test\)"
    [ FAIL ] user@server1.test.com
    [  OK  ] user@server2.test.com
    [ WARN ] user@server3.test.com
    [ FAIL ] user@server4.test.com
    [  OK  ] user@server5.test.com
    [ WARN ] user@server6.test.com
    [ FAIL ] user@server7.test.com
    [  OK  ] user@server8.test.com
    [ FAIL ] user@server9.test.com
    [  OK  ] user@server10.test.com

    OK:       4
    Fail:     4
    Warning:  2
             --
             10
    ```

From this last command it is important to highlight the following:
- The command to be used must be written with the absolute path. Remember that when doing an SSH the user's paths are not loaded. If you do not use an absolute path, it is very likely that the tests will always fail.
- It is very important to add the ampersand to the end of the command. This is because at the end of the test other commands are sent. You have to add this ampersand at the end if you are going to execute a **remote command** as a **user**. The ampersand should be omitted if what you want to test remote connectivity, for example if you want to prove that on the remote server you can become root, or if you want to know if the remote server can communicate with another server.
- When we want to test a remote command then the **OK message** proves that connectivity can be established and that the remote command succeeded.
- If you are always going to be doing the same test, then you can add the KSSH_TEST_CMD variable to your environment. This way you do not have to be writing it every time you want to do a quick review of your servers.

# Update

**03/12/2018:** Added test connection when listing servers
