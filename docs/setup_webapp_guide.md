# Web Application Setup Guide

This guide explains how to create and deploy Java web applications for the CSD430 course modules.

## Overview

Two scripts are provided to help you set up and deploy web applications. These scripts are located in the `scripts/` directory at the project root.

1. **scripts/setup_webapp.sh** - Creates a new webapp structure
2. **scripts/deploy_modules.sh** - Deploys all modules to Tomcat

## Prerequisites

### Apache Tomcat

Tomcat must be installed and configured. On macOS with Homebrew:

```bash
brew install tomcat@10
```

### Environment Variable

Set `CATALINA_HOME` in your shell profile (`~/.zshrc`):

```bash
export CATALINA_HOME=/opt/homebrew/opt/tomcat@10/libexec
```

Then reload your shell:

```bash
source ~/.zshrc
```

Verify Tomcat is running:

```bash
curl http://localhost:8080
```

## Creating a New Webapp

Use the `setup_webapp.sh` script to create a new web application:

### Basic Usage (from project root)

```bash
./scripts/setup_webapp.sh module_01
```

This creates the structure at: `modules/module_01/src/main/webapp/`

### Using Custom Base Path

```bash
./scripts/setup_webapp.sh module_01 snippets
```

This creates the structure at: `snippets/module_01/src/main/webapp/`

```bash
./scripts/setup_webapp.sh module_02 modules
```

This creates the structure at: `modules/module_02/src/main/webapp/`

### Help

```bash
./scripts/setup_webapp.sh --help
```

### What Gets Created

The script creates a complete Maven-style webapp structure:

```text
modules/module_XX/src/main/webapp/
├── index.jsp           # Welcome page with server info
└── WEB-INF/
    └── web.xml         # Webapp configuration
```

#### index.jsp

The generated `index.jsp` file displays:

- Servlet container information
- Server version details
- Request information (method, protocol, etc.)
- Parameter handling demo
- Current session and context info

#### WEB-INF/web.xml

Contains:

- Display name and description
- Welcome file list (index.jsp, index.html, index.htm)
- Example servlet configuration comments

## Deploying to Tomcat

### Method 1: Using deploy_modules.sh (Recommended)

Run the deployment script from the project root:

```bash
./scripts/deploy_modules.sh
```

This automatically:

- Scans the `modules/` and `snippets/` directories
- Finds any subdirectory with `src/main/webapp`
- Creates the webapp in Tomcat's webapps folder
- Prints deployment status

### Method 2: Manual Deployment

```bash
# Copy entire webapp directory
mkdir -p $CATALINA_HOME/webapps/module_01
cp -r modules/module_01/src/main/webapp/* $CATALINA_HOME/webapps/module_01/
```

### Method 3: Direct Copy

```bash
cp -r modules/module_01/src/main/webapp $CATALINA_HOME/webapps/module_01
```

## Accessing Your Web Application

After deployment, access your webapp at:

```text
http://localhost:8080/module_01/
```

Replace `module_01` with your actual module name.

### With Parameters

Test parameter handling:

```text
http://localhost:8080/module_01/?name=John&course=CSD430
```

## Example Workflow

### Creating a New Module

1. **Create the webapp structure:**

   ```bash
   ./scripts/setup_webapp.sh module_02
   ```

2. **Edit the files:**

   ```bash
   # Modify index.jsp with your content
   code modules/module_02/src/main/webapp/index.jsp
   
   # Or add additional JSP files
   touch modules/module_02/src/main/webapp/hello.jsp
   ```

3. **Deploy the module:**

   ```bash
   ./scripts/deploy_modules.sh
   ```

4. **Test in browser:**

   ```text
   http://localhost:8080/module_02/
   ```

### Updating an Existing Module

1. **Edit your JSP files:**

   ```bash
   code modules/module_01/src/main/webapp/index.jsp
   ```

2. **Redeploy:**

   ```bash
   ./scripts/deploy_modules.sh
   # or manually:
   cp -r modules/module_01/src/main/webapp/* $CATALINA_HOME/webapps/module_01/
   ```

3. **Refresh browser** (Ctrl+R or Cmd+R)

## Troubleshooting

### "no matches found" Error

**Problem:**

```bash
zsh: no matches found: module_01/src/main/webapp/*
```

**Cause:** The glob pattern has no files to match.

**Solution:**

1. Run `setup_webapp.sh` first to create the structure:

   ```bash
   ./scripts/setup_webapp.sh module_01
   ```

2. Then deploy:

   ```bash
   ./scripts/deploy_modules.sh
   ```

### CATALINA_HOME Not Set

**Problem:**

```text
Error: CATALINA_HOME is not set.
```

**Solution:**

```bash
export CATALINA_HOME=/opt/homebrew/opt/tomcat@10/libexec
source ~/.zshrc
```

### Tomcat Not Running

**Problem:**

```text
Warning: Tomcat appears to not be running.
```

**Solution:**

```bash
$CATALINA_HOME/bin/startup.sh
# Verify it's running
curl http://localhost:8080
```

### 404 Error

**Possible causes:**

1. Tomcat not restarted after deployment
2. Wrong URL path
3. Webapp directory missing files

**Solution:**

```bash
# Stop and restart Tomcat
$CATALINA_HOME/bin/shutdown.sh
$CATALINA_HOME/bin/startup.sh

# Check webapps directory
ls $CATALINA_HOME/webapps/

# Verify your webapp exists
ls $CATALINA_HOME/webapps/module_01/
```

## Project Structure

```text
csd430/
├── scripts/                    # Deployment and setup scripts
│   ├── setup_webapp.sh         # Create new webapp script
│   └── deploy_modules.sh       # Deploy all modules script
├── docs/
│   ├── setup_webapp_guide.md   # This file
│   └── tomcat_setup_guide.md   # Tomcat setup guide
├── modules/
│   ├── module_01/
│   │   └── src/main/webapp/
│   │       ├── index.jsp
│   │       └── WEB-INF/web.xml
│   └── module_02/
│       └── src/main/webapp/
│           ├── index.jsp
│           └── WEB-INF/web.xml
└── snippets/
    └── module_01/
        └── src/main/webapp/
            └── index.jsp
```

## Additional Resources

- [Tomcat Documentation](https://tomcat.apache.org/tomcat-10.0-doc/)
- [JSP Tutorial](https://docs.oracle.com/javaee/5/tutorial/doc/bnahu.html)
- [web.xml Schema](https://javaee.github.io/schemas-docs/web-app_4_0.xsd)
