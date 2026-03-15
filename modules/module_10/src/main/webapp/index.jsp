<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://example.com/csd430/tags" prefix="csd" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DEVCNX | JSP Custom Tags Demo</title>
    <link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --void-black: #001117;
            --signal-teal: #00DADD;
            --terminal-charcoal: #161B22;
            --surface-base: #001117;
            --surface-elevated: #161B22;
            --surface-overlay: #0D1117;
            --border-subtle: #21262D;
            --border-default: #30363D;
            --border-emphasized: #484F58;
            --text-primary: #FFFFFF;
            --text-secondary: #8B949E;
            --text-tertiary: #6E7681;
            --text-link: #00DADD;
            --text-disabled: #484F58;
            --success: #2EA043;
            --warning: #D29922;
            --error: #F85149;
            --info: #58A6FF;
            
            --font-main: 'JetBrains Mono', monospace;
            --text-display: 48px;
            --text-h1: 48px;
            --text-h2: 32px;
            --text-h3: 24px;
            --text-h4: 20px;
            --text-body: 16px;
            --text-small: 14px;
            --text-code: 14px;
            
            --weight-bold: 700;
            --weight-regular: 400;
            
            --space-xs: 4px;
            --space-sm: 8px;
            --space-md: 16px;
            --space-lg: 24px;
            --space-xl: 32px;
            --space-2xl: 40px;
            --space-3xl: 48px;
            
            --radius-none: 0px;
            --transition-fast: 100ms;
            --transition-base: 150ms;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: var(--font-main);
            font-size: var(--text-body);
            font-weight: var(--weight-regular);
            line-height: var(--leading-body, 24px);
            color: var(--text-primary);
            background-color: var(--void-black);
            min-height: 100vh;
            padding: var(--space-3xl) var(--space-lg);
        }
        
        .container {
            max-width: 960px;
            margin: 0 auto;
        }
        
        /* Header */
        .header {
            text-align: center;
            margin-bottom: var(--space-3xl);
        }
        
        .header h1 {
            font-size: var(--text-h1);
            font-weight: var(--weight-bold);
            line-height: 56px;
            letter-spacing: -0.02em;
            margin-bottom: var(--space-sm);
            color: var(--text-primary);
        }
        
        .header .subtitle {
            font-size: var(--text-body);
            color: var(--text-secondary);
            font-weight: var(--weight-regular);
        }
        
        .module-badge {
            display: inline-block;
            background: transparent;
            border: 1px solid var(--signal-teal);
            color: var(--signal-teal);
            padding: var(--space-sm) var(--space-lg);
            font-size: var(--text-small);
            margin-top: var(--space-lg);
            font-weight: var(--weight-regular);
        }
        
        /* Demo Cards */
        .demo-card {
            background: var(--terminal-charcoal);
            border: 1px solid var(--border-default);
            margin-bottom: var(--space-lg);
            overflow: hidden;
            transition: border-color var(--transition-fast) ease-out;
        }
        
        .demo-card:hover {
            border-color: var(--border-emphasized);
        }
        
        .demo-header {
            background: var(--surface-overlay);
            padding: var(--space-lg) var(--space-xl);
            border-bottom: 1px solid var(--border-subtle);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .demo-header h2 {
            font-size: var(--text-body);
            font-weight: var(--weight-bold);
            color: var(--text-primary);
            display: flex;
            align-items: center;
            gap: var(--space-md);
        }
        
        .demo-header h2 .demo-number {
            background: var(--signal-teal);
            color: var(--void-black);
            width: 24px;
            height: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: var(--text-small);
            font-weight: var(--weight-bold);
        }
        
        .demo-header .demo-tag {
            background: var(--surface-base);
            color: var(--text-secondary);
            padding: var(--space-xs) var(--space-md);
            font-size: var(--text-small);
            font-family: var(--font-main);
        }
        
        .demo-content {
            padding: var(--space-xl);
        }
        
        .code-block {
            background: var(--surface-base);
            border: 1px solid var(--border-subtle);
            padding: var(--space-lg);
            font-family: var(--font-main);
            font-size: var(--text-code);
            line-height: 20px;
            color: var(--text-primary);
            overflow-x: auto;
            margin-bottom: var(--space-lg);
        }
        
        .code-block .keyword { color: #c792ea; }
        .code-block .string { color: #c3e88d; }
        .code-block .tag { color: #82aaff; }
        .code-block .attr { color: #ffcb6b; }
        .code-block .comment { color: var(--text-tertiary); font-style: italic; }
        
        .output-label {
            font-size: var(--text-small);
            font-weight: var(--weight-bold);
            color: var(--text-tertiary);
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: var(--space-md);
            display: flex;
            align-items: center;
            gap: var(--space-sm);
        }
        
        .output-label::before {
            content: '';
            width: 6px;
            height: 6px;
            background: var(--signal-teal);
        }
        
        .output-box {
            background: var(--surface-overlay);
            border: 1px solid var(--border-subtle);
            padding: var(--space-xl);
            min-height: 60px;
        }
        
        /* Custom greeting tag styling - DEVCNX theme */
        .greeting-box {
            padding: var(--space-xl);
            background: var(--surface-overlay);
            border-left: 4px solid var(--signal-teal);
            margin: 0;
        }
        
        .greeting-box h3 {
            margin: 0 0 var(--space-sm) 0;
            color: var(--text-primary);
            font-size: var(--text-h4);
            font-weight: var(--weight-bold);
        }
        
        .greeting-box p {
            margin: 0;
            color: var(--text-secondary);
            font-size: var(--text-small);
        }
        
        /* How It Works */
        .how-it-works {
            background: var(--terminal-charcoal);
            border: 1px solid var(--border-default);
            padding: var(--space-xl);
            margin-top: var(--space-3xl);
        }
        
        .how-it-works h2 {
            font-size: var(--text-h3);
            font-weight: var(--weight-bold);
            color: var(--text-primary);
            margin-bottom: var(--space-xl);
            display: flex;
            align-items: center;
            gap: var(--space-md);
        }
        
        .how-it-works h2 .icon {
            color: var(--signal-teal);
        }
        
        .component-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: var(--space-lg);
        }
        
        .component-item {
            background: var(--surface-overlay);
            border: 1px solid var(--border-subtle);
            padding: var(--space-lg);
            transition: border-color var(--transition-fast) ease-out;
        }
        
        .component-item:hover {
            border-color: var(--signal-teal);
        }
        
        .component-item h3 {
            font-size: var(--text-small);
            font-weight: var(--weight-bold);
            color: var(--signal-teal);
            margin-bottom: var(--space-md);
            font-family: var(--font-main);
        }
        
        .component-item ul {
            list-style: none;
            padding: 0;
        }
        
        .component-item li {
            padding: var(--space-xs) 0;
            padding-left: var(--space-lg);
            position: relative;
            color: var(--text-secondary);
            font-size: var(--text-small);
        }
        
        .component-item li::before {
            content: '→';
            position: absolute;
            left: 0;
            color: var(--signal-teal);
        }
        
        code {
            background: var(--surface-base);
            color: var(--signal-teal);
            padding: 2px 6px;
            font-family: var(--font-main);
            font-size: var(--text-small);
        }
        
        /* Footer */
        .footer {
            text-align: center;
            margin-top: var(--space-3xl);
            padding-top: var(--space-xl);
            border-top: 1px solid var(--border-subtle);
        }
        
        .footer a {
            color: var(--text-secondary);
            text-decoration: none;
            font-weight: var(--weight-regular);
            margin: 0 var(--space-md);
            padding: var(--space-sm) var(--space-lg);
            border: 1px solid var(--border-default);
            transition: all var(--transition-fast) ease-out;
            display: inline-flex;
            align-items: center;
            gap: var(--space-sm);
        }
        
        .footer a:hover {
            color: var(--signal-teal);
            border-color: var(--signal-teal);
        }
        
        @media (max-width: 600px) {
            body {
                padding: var(--space-lg) var(--space-md);
            }
            
            .header h1 {
                font-size: var(--text-h2);
                line-height: 40px;
            }
            
            .demo-content, .how-it-works {
                padding: var(--space-md);
            }
            
            .component-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>JSP Custom Tags Demo</h1>
            <p class="subtitle">Creating Custom Tags in JSP — Module 10.2 Assignment</p>
            <span class="module-badge">CSD430 Server-Side Development</span>
        </div>
        
        <!-- Demo 1: Basic greeting -->
        <div class="demo-card">
            <div class="demo-header">
                <h2><span class="demo-number">1</span>Basic Greeting</h2>
                <span class="demo-tag">name attribute</span>
            </div>
            <div class="demo-content">
                <div class="code-block">
                    <span class="keyword">&lt;%@</span> <span class="attr">taglib</span> <span class="attr">uri</span>=<span class="string">"http://devcnx.com/csd430/tags"</span> <span class="attr">prefix</span>=<span class="string">"csd"</span> <span class="keyword">%&gt;</span><br><br>
                    <span class="tag">&lt;csd:greeting</span> <span class="attr">name</span>=<span class="string">"Brittaney"</span> <span class="tag">/&gt;</span>
                </div>
                <div class="output-label">Live Output</div>
                <div class="output-box">
                    <csd:greeting name="Brittaney" />
                </div>
            </div>
        </div>
        
        <!-- Demo 2: Short time format -->
        <div class="demo-card">
            <div class="demo-header">
                <h2><span class="demo-number">2</span>Short Time Format</h2>
                <span class="demo-tag">timeFormat="short"</span>
            </div>
            <div class="demo-content">
                <div class="code-block">
                    <span class="tag">&lt;csd:greeting</span> <span class="attr">name</span>=<span class="string">"Student"</span> <span class="attr">timeFormat</span>=<span class="string">"short"</span> <span class="tag">/&gt;</span>
                </div>
                <div class="output-label">Live Output</div>
                <div class="output-box">
                    <csd:greeting name="Student" timeFormat="short" />
                </div>
            </div>
        </div>
        
        <!-- Demo 3: Medium format -->
        <div class="demo-card">
            <div class="demo-header">
                <h2><span class="demo-number">3</span>Medium Time Format</h2>
                <span class="demo-tag">timeFormat="medium"</span>
            </div>
            <div class="demo-content">
                <div class="code-block">
                    <span class="tag">&lt;csd:greeting</span> <span class="attr">name</span>=<span class="string">"Developer"</span> <span class="attr">timeFormat</span>=<span class="string">"medium"</span> <span class="tag">/&gt;</span>
                </div>
                <div class="output-label">Live Output</div>
                <div class="output-box">
                    <csd:greeting name="Developer" timeFormat="medium" />
                </div>
            </div>
        </div>
        
        <!-- Demo 4: No name attribute -->
        <div class="demo-card">
            <div class="demo-header">
                <h2><span class="demo-number">4</span>Optional Name</h2>
                <span class="demo-tag">no attributes</span>
            </div>
            <div class="demo-content">
                <div class="code-block">
                    <span class="tag">&lt;csd:greeting</span> <span class="attr">timeFormat</span>=<span class="string">"full"</span> <span class="tag">/&gt;</span>
                </div>
                <div class="output-label">Live Output</div>
                <div class="output-box">
                    <csd:greeting timeFormat="full" />
                </div>
            </div>
        </div>
        
        <!-- Demo 5: Dynamic attribute -->
        <div class="demo-card">
            <div class="demo-header">
                <h2><span class="demo-number">5</span>Dynamic Attribute Values</h2>
                <span class="demo-tag">JSP expression</span>
            </div>
            <div class="demo-content">
                <div class="code-block">
                    <span class="keyword">&lt;%</span> <span class="comment">// JSP scriptlet for dynamic value</span><br>
                    &nbsp;&nbsp;String userName = request.getParameter("user");<br>
                    &nbsp;&nbsp;if (userName == null) userName = "World";<br>
                    <span class="keyword">%&gt;</span><br><br>
                    <span class="tag">&lt;csd:greeting</span> <span class="attr">name</span>=<span class="string">"&lt;%= userName %&gt;"</span> <span class="tag">/&gt;</span>
                </div>
                <div class="output-label">Live Output (user=World)</div>
                <div class="output-box">
                    <csd:greeting name="World" />
                </div>
            </div>
        </div>
        
        <!-- How It Works -->
        <div class="how-it-works">
            <h2><span class="icon">[+]</span>How It Works</h2>
            <div class="component-grid">
                <div class="component-item">
                    <h3>Tag Handler Class</h3>
                    <ul>
                        <li>Extends <code>SimpleTagSupport</code></li>
                        <li>Setter methods for each attribute</li>
                        <li>Overrides <code>doTag()</code> method</li>
                        <li>Uses <code>getJspContext().getOut()</code></li>
                    </ul>
                </div>
                <div class="component-item">
                    <h3>Tag Library Descriptor</h3>
                    <ul>
                        <li>XML file in <code>WEB-INF/</code></li>
                        <li>Maps tag name to handler class</li>
                        <li>Defines attribute metadata</li>
                        <li>Specifies required/optional attrs</li>
                    </ul>
                </div>
                <div class="component-item">
                    <h3>JSP Page Usage</h3>
                    <ul>
                        <li>Declare with <code>&lt;%@ taglib %&gt;</code></li>
                        <li>Specify URI and prefix</li>
                        <li>Call like built-in JSP tags</li>
                        <li>Pass attributes as needed</li>
                    </ul>
                </div>
            </div>
        </div>
        
        <div class="footer">
            <a href="https://github.com/devcnx/csd430">[repo] GitHub Repository</a>
            <a href="index.jsp">[refresh] Demo</a>
        </div>
    </div>
</body>
</html>