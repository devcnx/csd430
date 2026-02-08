# Tomcat Setup & Deployment Guide (macOS / Homebrew)

## Tomcat Location

```bash
/opt/homebrew/opt/tomcat@10/libexec/
```

The `CATALINA_HOME` environment variable should point here:

```bash
export CATALINA_HOME=/opt/homebrew/opt/tomcat@10/libexec
```

To make this permanent, add the line above to your `~/.zshrc` file.

---

## Starting & Stopping Tomcat

**Start:**

```bash
$CATALINA_HOME/bin/startup.sh
```

**Stop:**

```bash
$CATALINA_HOME/bin/shutdown.sh
```

**Verify it's running:**

Open `http://localhost:8080` in your browser. You should see the Tomcat welcome page.

---

## Deploying a Web Application

### 1. Create the deployment directory

```bash
mkdir -p $CATALINA_HOME/webapps/<app-name>
```

### 2. Copy your webapp files

```bash
cp -r <project>/src/main/webapp/* $CATALINA_HOME/webapps/<app-name>/
```

**Example for Module 1:**

```bash
mkdir -p $CATALINA_HOME/webapps/module1
cp -r module1/src/main/webapp/* $CATALINA_HOME/webapps/module1/
```

### Alternative: Using the deploy_modules.sh Script

The project provides a convenient script for deploying all modules:

```bash
./scripts/deploy_modules.sh
```

This script automatically scans the `modules/` and `snippets/` directories and deploys any found web applications.

### 3. Access in browser

```bash
http://localhost:8080/<app-name>/
```

Example: `http://localhost:8080/module1/`

---

## Redeploying After Changes

If you edit your JSP or other files, re-copy them to the webapps directory:

```bash
cp -r module1/src/main/webapp/* $CATALINA_HOME/webapps/module1/
```

JSP changes are usually picked up automatically without restarting Tomcat. For `web.xml` or Java class changes, restart Tomcat:

```bash
$CATALINA_HOME/bin/shutdown.sh && $CATALINA_HOME/bin/startup.sh
```

---

## Expected Project Structure

```bash
<app-name>/
└── src/
    └── main/
        └── webapp/
            ├── WEB-INF/
            │   └── web.xml
            ├── index.jsp
            └── (other files: css/, js/, etc.)
```

When deployed, the contents of `webapp/` end up in:

```bash
$CATALINA_HOME/webapps/<app-name>/
├── WEB-INF/
│   └── web.xml
├── index.jsp
└── ...
```

---

## Troubleshooting

| Problem | Solution |
| --------- | ---------- |
| `CATALINA_HOME` is empty | Run `export CATALINA_HOME=/opt/homebrew/opt/tomcat@10/libexec` |
| `no such file or directory: .../bin/catalina` | Use `catalina.sh` (scripts have `.sh` extension) |
| Port 8080 already in use | Run `lsof -i :8080` to find the process, then `kill <PID>` |
| 404 error in browser | Check that files exist in `$CATALINA_HOME/webapps/<app-name>/` |
| JSP shows raw code instead of rendering | Ensure Tomcat is running and you're accessing via `localhost:8080`, not opening the file directly |

---

## Quick Start

1. **Set up your environment:**

   ```bash
   export CATALINA_HOME=/opt/homebrew/opt/tomcat@10/libexec
   source ~/.zshrc
   ```

2. **Start Tomcat:**

   ```bash
   $CATALINA_HOME/bin/startup.sh
   ```

3. **Create a new webapp:**

   ```bash
   ./scripts/setup_webapp.sh module_01
   ```

4. **Deploy to Tomcat:**

   ```bash
   ./scripts/deploy_modules.sh
   # or manually:
   mkdir -p $CATALINA_HOME/webapps/module_01
   cp -r modules/module_01/src/main/webapp/* $CATALINA_HOME/webapps/module_01/
   ```

5. **Access in browser:**

   ```text
   http://localhost:8080/module_01/
   ```
