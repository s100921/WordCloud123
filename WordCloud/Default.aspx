<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron" style="height: 830px">
        <h1>Welcome to Word Cloud Generator</h1>
        <div style="height: 650px; position: relative; float: left; padding-right: 20px; left: 0px; top: 0px; width: 500px;">
            <asp:TextBox ID="TextBox1" runat="server" Height="445px" TextMode="MultiLine" Width="490px"></asp:TextBox>
            <br />
            <asp:HiddenField ID="HiddevActiveTab" runat="server" />
            <div class="panel panel-default" style="width: 490px; height: 200px; padding: 10px; margin-top: 20px">
                <div id="Tabs" role="tabpanel">
                    <!-- Nav tabs -->
                    <ul class="nav nav-tabs" role="tablist">
                        <li class="active"><a href="#personal" aria-controls="personal" role="tab" data-toggle="tab">Cloud</a></li>
                        <li><a id="editL" href="#editList" aria-controls="edList" role="tab" data-toggle="tab">Edit List</a></li>
                        <li><a href="#save" aria-controls="save" role="tab" data-toggle="tab">Save</a></li>
                        <li><a href="#examples" aria-controls="examples" role="tab" data-toggle="tab">Examples</a></li>

                    </ul>
                    <!-- Tab panes -->
                    <div class="tab-content" style="padding-top: 10px">
                        <div role="tabpanel" class="tab-pane active" id="personal">
                            Add text into the textbox above or browse for a file to generate the word cloud!&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input id="Button1" type="button" onclick="Populate()" value="Generate" style="width: 107px" /><input id="File1" type="file" onchange="onFileSelected(event)" style="width: 301px" />&nbsp;
                        </div>

                        <div role="tabpanel" class="tab-pane" id="editList">
                            <textarea id="TextArea1" name="S1" style="width: 471px; height: 122px"></textarea>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="save">
                            <%--<input id="Button3" runat="server" type="button" onclick="ExportToPDF()" value="Export to PDF" />--%>
                            <a href="#" id="btn-download" download="my-file-name.png">Download PNG</a>
                            <a href="#" id="Button3"  OnClick="ExportToPDF()" >Download PDF</a>
                           <%-- <asp:Button ID="btnUpload" runat="server" Text="dbUpload" OnClick="btnUpload_Click" />--%>
                            <br />
                            <asp:Label ID="lblMessage" runat="server" Text="" Font-Names="Arial"></asp:Label>
                        </div>
                        <div role="tabpanel" class="tab-pane" id="examples">
                            <select id="sampleTitledropdown">
                                <option selected="selected">Pick a category</option>
                                <option value="computing">Computing</option>
                                <option value="finance">Finance</option>
                                <option value="politics">Politics</option>
                                <option value="vehicles">Vehicles</option>

                            </select>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div style="background-color: #000066; height: 666px; position: relative; width: 520px; float: left;" id="cloudM">
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="titeLabel" runat="server" Font-Bold="True" Font-Names="Segoe UI" Font-Size="XX-Large" Font-Underline="True" ForeColor="#3366FF"></asp:Label>
            <div id="cloud">
            </div>
        </div>

    </div>

    <script src="Scripts/d3.min.js"></script>
    <script src="Scripts/d3.layout.cloud.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.3/jspdf.debug.js"></script>
    <script type="text/javascript" src="http://canvg.github.io/canvg/rgbcolor.js"></script>
    <script type="text/javascript" src="http://canvg.github.io/canvg/StackBlur.js"></script>
    <script type="text/javascript" src="http://canvg.github.io/canvg/canvg.js"></script>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

    <script type="text/javascript">

        var tb2 = "";
        var string1 = "";
        var string5 = "";
        var string3 = "";
        var tb2Text = [];
        var tb2Size = [];
        var element;
        var height;
        var width;
        var maxCount;
        var minCount;
        var maxWordSize;
        var minWordSize;
        var spread;
        var step;
        var sWord;



        var finance = ["Account", "Accounting", "Accrue", "Accumulate", "Acquisition", "Activity", "Adjustable", "Adjustment", "AMEX", "Amortization", "Annual",
                       "Annuity", "Appraisal", "Arbitrage", "Arrangement", "Arrears", "Assets", "Authentic", "Authorization", "Automated", "Average", "Averaging",
                       "Balance", "Bank", "Bankrupt", "Barter", "Bear", "Beneficiary", "Bid", "Bond", "Bracket", "Broker", "Brokerage", "Bull", "Buying", "Buyout",
                       "Calculation", "Call", "Capital", "Cartel", "Cashier", "Certificate", "Certified", "Chart", "Churn", "Circulation", "Clearinghouse",
                       "Collateral", "Collect", "Commission", "Commodity", "Compensation", "Competitor", "Compound", "Conglomerate", "Consolidation", "Consortium",
                       "Consumer", "Convertible", "Correction", "Cost", "Counter", "Countersign", "Credit", "Currency", "Custodian", "Deal", "Debenture", "Debit",
                       "Debt", "Deductible", "Deduction", "Default", "Delinquency", "Demand", "Depository", "Depreciation", "Depression", "Deregulation", "Designation",
                       "Devaluation", "Differential", "Discount", "Distribution", "Diversify", "Dividend", "Downturn", "Draft", "Driven", "Dump", "Earn", "Economy",
                       "Electronic", "Elimination", "Embezzlement", "Endorse", "Enterprise", "Entity", "Equity", "Escrow", "ESOP", "Estimation", "Evaluation", "Exceed",
                       "Exchange", "Exorbitant", "Expectation", "Extortion", "Failure", "Federal", "Fees", "Fiduciary", "Finance", "Fiscal", "Fixed", "Float", "Foreclosure",
                       "Forfeiture", "Frugality", "Fulfillment", "Fund", "Funds", "Gain", "GDP", "Gold", "Government", "Growth", "Guarantee", "Guaranty", "Hiring",
                       "Identification", "Illegal", "Imprint", "Income", "Index", "Industrial", "Inflated", "Insolvent", "Installment", "Institution", "Insufficient",
                       "Intangible", "Interest", "Intermediary", "Intervention", "Invalidate", "Investment", "IRA", "Issue", "Kiting", "Laundering", "LBO", "Lending",
                       "Leverage", "Liability", "Lien", "Liquidity", "Loan", "Long-term", "Lucrative", "Maintain", "Margin", "Market", "Maturity", "Member", "Mercantile",
                       "Merger", "Money", "Monopoly", "Municipals", "Negotiable", "Non-speculative", "Note", "NYSE", "Obligation", "Operation", "Option", "Overcompensate",
                       "Oversight", "Ownership", "Payment", "Peaks", "Percent", "Planning", "Pledge", "Points", "Portfolio", "Practice", "Predetermine", "Premium", "Principal",
                       "Product", "Profit", "Progressive", "Public", "Quality", "Qualm", "Quantity", "Questionable", "Quick", "Quittance", "Quote", "Raid", "Rally",
                       "Ramification", "Rate", "Ratio", "Recession", "Record", "Recoup", "Recourse", "Redemption", "Reduction", "Regulation", "Reimburse", "Reliability",
                       "Reserves", "Retirement", "Risk", "Rumors", "Sale", "Savings", "Securities", "Select", "Selling", "Shares", "Shylock", "Slump", "Solvency", "Speculate",
                       "Speculative", "Split", "Stagflation", "Stock", "Stocks", "Subscription", "Summary", "Surety", "Surplus", "Survivorship", "Swap", "Takeover", "Taxes",
                       "Technical", "Tender", "Thrifts", "Trade", "Transaction", "Transfer", "Transferable", "Treasury", "Trends", "Uncollected", "Underwriter", "Unit",
                       "Unofficial", "Unregulated", "Unsecured", "Untaxed", "Usury", "Utilities", "Valuable", "Value", "Variable", "Vault", "Venture", "Void", "Voucher",
                       "Wage", "Warrant", "Wide-ranging", "Withdrawal", "Yield"];
        var vehicles = [];
        var politics = ["Absentee", "Accountable", "Activist", "Adverse", "Advertising", "Advice", "Advise", "Affiliation", "Aggressive", "Amendment", "Announcement",
                        "Anthem", "Appeal", "Appearance", "Appoint", "Approach", "Appropriation", "Arguments", "Articulate", "Aspiration", "Asset", "Assimilation", "Audience",
                        "Authorization", "Background", "Bait", "Ballot", "Bandwagon", "Barnstorm", "Behavior", "Beliefs", "Biannual", "Bias", "Bicameral", "Bill", "Bipartisan",
                        "Boondoggle", "Brochure", "Budget", "Bunk", "Bureaucracy", "Cabinet", "Campaign", "Candidate", "Canvass", "Capitalize", "Career", "Catalyst", "Caucus",
                        "Ceiling", "Centrist", "Challenge", "Challenger", "Changes", "Charismatic", "Choice", "Citation", "Civic", "Coalition", "Coattail", "Collaboration", "Colleague",
                        "Collective", "Commitments", "Committee", "Commonality", "Communication", "Compassion", "Concede", "Concessions", "Confidence", "Congress", "Congressional",
                        "Conscience", "Consequence", "Conservative", "Constituent", "Constitution", "Consultation", "Contribution", "Controversy", "Convene", "Convention", "Council",
                        "Curiosity", "Cycle", "Debate", "Decision", "Decisive", "Declaration", "Defeat", "Deficit", "Delegate", "Deliberate", "Deliberation", "Democracy", "Democrat",
                        "Democratic", "Derision", "Destiny", "Diligent", "Diplomat", "Disapproval", "Discourse", "Discreet", "Discussion", "Disheartened", "Dishonesty", "Dissatisfaction",
                        "District", "Distrust", "Diverse", "Division", "Dogma", "Dominate", "Donation", "Donor", "Dossier", "Dynamic", "Effective", "Efficient", "Elation", "Elevate",
                        "Eloquence", "Emphasis", "Enact", "Endorsement", "Engaging", "Equal", "Ethics", "Euphoria", "Excessive", "Executive", "Experience", "Faction", "Federal", "Feud",
                        "Filibuster", "Flawed", "Focus", "Forum", "Fraud", "Freedom", "Fundamental", "Funding", "Fundraiser", "Gambit", "Gerrymander", "Glaring", "GOP", "Government",
                        "Grateful", "Handshakes", "Heckle", "Historic", "Honesty", "Hooray", "Hypocrisy", "Immigrants", "Impound", "Inalienable", "Incentive", "Incorporate", "Incumbency",
                        "Incumbent", "Independent", "Independent", "Indulge", "Infallible", "Influx", "Informative", "Initiative", "Innuendo", "Inspiring", "Integrity", "Interests", "Investigate",
                        "Involvement", "Irresponsible", "Issues", "Jeopardy", "JUBILANT", "Judge", "Judicial", "Keen", "Knowledge", "Landslide", "Law", "Leader", "Leadership", "Leanings", "Legal",
                        "Legalization", "Legislature", "Liberal", "Listening", "Lobbyist", "Lone", "Loser", "Loss", "Loyalty", "Magistrate", "Majority", "Mandate", "Meaningful", "Measures",
                        "Media", "Meetings", "Mentor", "Minority", "Misinformation", "Motives", "Mudslinging", "National", "Nationwide", "Negativity", "Network", "Nominate", "Nominee", "Nonpartisan",
                        "Obligation", "Obsequious", "Offensive", "Office", "Official", "Opine", "Opinion", "Opinionated", "Opportunity", "Opposition", "Orator", "Outspoken", "Ovation", "Pamphlets",
                        "Pardon", "Participation", "Partisanship", "Party", "Patriotism", "Petition", "Platform", "Pledge", "Plurality", "Polarize", "Policy", "Polite", "Politician", "Politics",
                        "Poll", "Polling", "Pollster", "Popular", "Popularity", "Pragmatist", "Praise", "Precinct", "Predictions", "Prescient", "Press", "Pride", "Primary",
                        "Priority", "Proactive", "Process", "Progressive", "Projection", "Promises", "Propaganda", "Proponent", "Proposal", "Purpose", "Query", "Quest", "Questions", "Quorum",
                        "Quotes", "Race", "Ratify", "Re-election", "Reapportionment", "Recall", "Recognition", "Reconciliation", "Recount", "Recrimination", "Redistrict", "Referendum", "Reform",
                        "Registration", "Regulate", "Representation", "Republican", "Rescind", "Resignation", "Resilience", "Restrictions", "Retort", "Reveal", "Revelations", "Revenues", "Rhetoric",
                        "Runoff", "Scope", "Senate", "Seniority", "Shift", "Shortcoming", "Shuffle", "Sidelines", "Sinecure", "Skill", "Slate", "Slogan", "Solicitation", "Solution", "Spar",
                        "Spectacle", "Speculate", "Spending", "Spin", "Stakes", "Stance", "Statute", "Strategist", "Strategy", "Stump", "Subcommittee", "Subjects", "Success", "Suffrage", "Support",
                        "System", "Tactics", "Tally", "Taxpayer", "Term", "Ticket", "Topic", "Trust", "Turnout", "Ultimate", "Unanimous", "Uncommitted", "Unfair", "Uniformity",
                        "Unity", "Unopposed", "Unprecedented", "Unwind", "Upcoming", "Upset", "Vacancy", "Veto", "Viable", "Victor", "Victory", "Vie", "Viewpoint", "Views", "Violations", "VIP", "Volunteers",
                        "Voter", "Vulnerability", "Ward", "Whistle-stop", "Wild-card", "Win", "Winner", "Withdraw", "Withhold", "Woo", "Xenophobic", "Yell", "Yield", "Zeal", "Zealous", "Zone"];

        var computing = ["algorithm", "analog", "app", "application", "array", "backup", "bandwidth", "binary", "bit", "bitmap", "bite", "blog", "blogger", "bookmark", "boot", "broadband", "browser", "buffer",
                         "bug", "bus", "byte", "cache", "caps-lock", "captcha", "CD-ROM", "client", "clipart", "clipboard", "cloudcomputing", "command", "compile", "compress", "computer", "configure", "cookie",
                         "copy", "cybercrime", "cyberspace", "dashboard", "data", "database", "datamining", "debug", "decompress", "delete", "desktop", "development", "digital", "disk", "DNS", "document", "domain",
                         "dot", "download", "drag", "dynamic", "email", "emoticon", "encrypt", "encryption", "enter", "exabyte", "file", "finder", "firewall", "firmware", "flaming", "flash", "flashdrive",
                         "floppydisk", "flowchart", "folder", "font", "format", "frame", "freeware", "gigabyte", "graphics", "hack", "hacker", "hardware", "homepage", "host", "html", "hyperlink", "hypertext",
                         "icon", "inbox", "integer", "interface", "Internet", "IPaddress", "iteration", "Java", "joystick", "junkmail", "kernel", "key", "keyboard", "keyword", "laptop", "laserprinter", "link", "login", "logout",
                         "logic", "lurking", "mainframe", "macro", "malware", "media", "memory", "mirror", "modem", "monitor", "motherboard", "mouse", "multimedia", "net", "network", "node", "notebook", "offline", "online",
                         "opensource", "operatingsystem", "option", "output", "page", "password", "paste", "path", "phishing", "piracy", "pirate", "platform", "plug-in", "podcast", "pop-up", "portal", "print", "printer", "privacy",
                         "process", "program", "programmer", "protocol", "queue", "QWERTY", "real-time", "reboot", "resolution", "restore", "root", "router", "runtime", "save", "scan", "scanner", "screen", "screenshot", "script", "scroll",
                         "security", "server", "shareware", "shell", "shift", "snapshot", "social-networking", "software", "spam", "spammer", "spreadsheet", "statusbar", "storage", "spyware", "supercomputer", "surf", "syntax",
                         "table", "tag", "template", "terabyte", "terminal", "thread", "toolbar", "trash", "Trojan-horse", "typeface", "undo", "Unix", "upload", "user-interface", "username", "URL", "user", "utility", "version", "virtual",
                         "virus", "web", "webmaster", "website", "widget", "window", "wireless", "wiki", "workstation", "worm", "WWW", "XML", "zip"];
        var medical = [];

        function onFileSelected(event) {
            var selectedFile = event.target.files[0];
            var reader = new FileReader();
            var result = document.getElementById("<%= TextBox1.ClientID %>");

            reader.onload = function (event) {
                result.innerHTML = event.target.result;
                document.getElementById("TextArea1").value = " ";
            };

            reader.readAsText(selectedFile);

        }


        document.getElementById("sampleTitledropdown").onchange = function () {

            d3.select("svg").remove();
            width = 470;
            height = 590;
            var skillsToDraw;
            var fill;
            maxWordSize = width * 0.15;
            minWordSize = maxWordSize / 5;
            spread = maxCount - minCount;
            if (spread <= 0) spread = 1;
            step = (maxWordSize - minWordSize) / spread;

            if (this.value === "computing") {
                //do this function

                maxCount = 80;
                minCount = 45;


                skillsToDraw = [

                    { text: 'JavaScript', size: 80 },
                    { text: 'D3js', size: 30 },
                    { text: 'coffeescript', size: 50 },
                    { text: 'Geolocation', size: 50 },
                    { text: 'AngularJS', size: 60 },
                    { text: 'Ruby', size: 60 },
                    { text: 'ECMAScript', size: 30 },
                    { text: 'Actionscript', size: 20 },
                    { text: 'Linux', size: 40 },
                    { text: '<canvas>', size: 40 },
                    { text: '<audio>', size: 30 },
                    { text: '<video>', size: 25 },
                    { text: 'XMLHttpRequest', size: 40 },
                    { text: 'HTML', size: 50 },
                    { text: 'JAVA', size: 76 },
                    { text: 'JSONparse', size: 76 }
                ];

                document.getElementById("<%= titeLabel.ClientID %>").innerHTML = "Title : Computing";
            }
            else if (this.value === "finance") {
                //do this function
                maxCount = 80;
                minCount = 45;

                skillsToDraw = [

                    { text: 'JavaScript', size: 80 },
                    { text: 'D3js', size: 30 },
                    { text: 'coffeescript', size: 50 },
                    { text: 'Geolocation', size: 50 },
                    { text: 'AngularJS', size: 60 },
                    { text: 'Ruby', size: 60 },
                    { text: 'ECMAScript', size: 30 },
                    { text: 'Actionscript', size: 20 },
                    { text: 'Linux', size: 40 },
                    { text: '<canvas>', size: 40 },
                    { text: '<audio>', size: 30 },
                    { text: '<video>', size: 25 },
                    { text: 'XMLHttpRequest', size: 40 },
                    { text: 'HTML', size: 50 },
                    { text: 'JAVA', size: 76 },
                    { text: 'JSONparse', size: 76 }
                ];

                document.getElementById("<%= titeLabel.ClientID %>").innerHTML = "Title : Fianance";
            }
            else if (this.value === "politics") {
                maxCount = 80;
                minCount = 45;

                skillsToDraw = [
                    { text: 'JavaScript', size: 80 },
                    { text: 'D3js', size: 30 },
                    { text: 'coffeescript', size: 50 },
                    { text: 'Geolocation', size: 50 },
                    { text: 'AngularJS', size: 60 },
                    { text: 'Ruby', size: 60 },
                    { text: 'ECMAScript', size: 30 },
                    { text: 'Actionscript', size: 20 },
                    { text: 'Linux', size: 40 },
                    { text: '<canvas>', size: 40 },
                    { text: '<audio>', size: 30 },
                    { text: '<video>', size: 25 },
                    { text: 'XMLHttpRequest', size: 40 },
                    { text: 'HTML', size: 50 },
                    { text: 'JAVA', size: 76 },
                    { text: 'JSONparse', size: 76 }
                ];


                document.getElementById("<%= titeLabel.ClientID %>").innerHTML = "Title : Politics";
            }
            else if (this.value === "vehicles") {
                maxCount = 80;
                minCount = 45;

                skillsToDraw = [
                    { text: 'JavaScript', size: 80 },
                    { text: 'D3js', size: 30 },
                    { text: 'coffeescript', size: 50 },
                    { text: 'Geolocation', size: 50 },
                    { text: 'AngularJS', size: 60 },
                    { text: 'Ruby', size: 60 },
                    { text: 'ECMAScript', size: 30 },
                    { text: 'Actionscript', size: 20 },
                    { text: 'Linux', size: 40 },
                    { text: '<canvas>', size: 40 },
                    { text: '<audio>', size: 30 },
                    { text: '<video>', size: 25 },
                    { text: 'XMLHttpRequest', size: 40 },
                    { text: 'HTML', size: 50 },
                    { text: 'JAVA', size: 76 },
                    { text: 'JSONparse', size: 76 }
                ];

                document.getElementById("<%= titeLabel.ClientID %>").innerHTML = "Title : Vehicles";
            }

            fill = d3.scale.category20();

            d3.layout.cloud()
                .size([width, height])
                .words(skillsToDraw)
                .rotate(function () {
                    return ~~(Math.random() * 2) * 90;
                })
                .font("Impact")
                .fontSize(function (d) {
                    return d.size;
                })
                .on("end", drawSkillCloud)
                .start();

            function drawSkillCloud(words) {
                d3.select("#cloud")
                    .append("svg")
                    .attr("width", width)
                    .attr("height", height)
                    .style("margin-left", "30px")
                    .style("margin-top", "15px")
                    .append("g")
                    .attr("transform", "translate(" + ~~(Math.random() * 3) * 45 + "," + ~~(Math.random() * 1) * 90 + ")")
                    .selectAll("text")
                    .data(words)
                    .enter()
                    .append("text")
                    .style("font-size",
                        function (d) {
                            return d.size + "px";
                        })
                    .style("-webkit-touch-callout", "none")
                    .style("-webkit-user-select", "none")
                    .style("-khtml-user-select", "none")
                    .style("-moz-user-select", "none")
                    .style("-ms-user-select", "none")
                    .style("user-select", "none")
                    .style("cursor", "default")
                    .style("font-family", "Calibri")
                    .style("fill",
                        function (d, i) {
                            return fill(i);
                        })
                    .attr("text-anchor", "middle")
                    .attr("transform",
                        function (d) {
                            return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                        })
                    .text(function (d) {
                        return d.text;
                    });
            }

            // set the viewbox to content bounding box (zooming in on the content, effectively trimming whitespace)

            var svg = document.getElementsByTagName("svg")[0];
            var bbox = svg.getBBox();
            var viewBox = [bbox.x, bbox.y, bbox.width, bbox.height].join(" ");
            svg.setAttribute("viewBox", viewBox);
        };


function search() {
    clear();
    var words = (function () {

        var sWords = document.getElementById("<%= TextBox1.ClientID %>").value.trim().replace(/[,;:_=+^~*?%$&@#/\|\[\](){}<>!"1234567890.']/g, '\n').split(/[\s\/]+/g).sort();
        var iWordsCount = sWords.length; // count w/ duplicates

        var ignore = ["", " ", "a", "about", "above", "across", "after", "afterwards", "again", "against", "all", "almost",
                       "alone", "along", "already", "also", "although", "always", "am", "among", "amongst", "amoungst", "amount", "an",
                       "and", "another", "any", "anyhow", "anyone", "anything", "anyway", "anywhere", "are", "around", "as", "at",
                       "back", "be", "became", "because", "become", "becomes", "becoming", "been", "before", "beforehand", "behind",
                       "being", "below", "beside", "besides", "between", "beyond", "bill", "both", "bottom", "but", "by", "call", "can",
                       "cannot", "cant", "could", "couldnt", "cry", "describe", "do", "done", "down", "due", "during", "each", "eight",
                       "either", "eleven", "else", "elsewhere", "empty", "enough", "etc", "even", "ever", "every", "everyone", "everything",
                       "everywhere", "except", "few", "fifteen", "fify", "fill", "find", "fire", "first", "five", "for", "former", "formerly",
                       "forty", "found", "four", "from", "front", "full", "further", "get", "give", "go", "had", "has", "hasnt", "have", "he",
                       "hence", "her", "here", "hereafter", "hereby", "herein", "hereupon", "hers", "herself", "him", "himself", "his", "how",
                       "however", "hundred", "i", "if", "in", "inc", "indeed", "interest", "into", "is", "it", "its", "itself", "ive", "keep", "last",
                       "latter", "latterly", "least", "less", "made", "many", "may", "me", "meanwhile", "might", "mine", "more", "moreover",
                       "most", "mostly", "move", "much", "must", "my", "myself", "name", "namely", "neither", "never", "nevertheless", "next",
                       "nine", "no", "nobody", "none", "not", "nothing", "now", "nowhere", "of", "off", "often", "on", "once", "one", "only", "onto",
                       "or", "other", "others", "otherwise", "our", "ours", "ourselves", "out", "over", "own", "part", "per", "perhaps", "please",
                       "put", "rather", "same", "see", "seem", "seemed", "seeming", "seems", "serious", "several", "she", "should", "show", "side",
                       "since", "sincere", "six", "sixty", "so", "some", "somehow", "someone", "something", "sometime", "sometimes", "somewhere",
                       "still", "such", "system", "take", "ten", "than", "that", "the", "their", "them", "themselves", "then", "there", "thereafter",
                       "thereby", "therefore", "therein", "thereupon", "these", "they", "thick", "thin", "third", "this", "those", "though", "three",
                       "through", "throughout", "thus", "to", "together", "too", "top", "toward", "towards", "twelve", "twenty", "two", "under", "until",
                       "up", "upon", "us", "very", "via", "was", "we", "well", "were", "what", "whatever", "when", "whence", "whenever", "where", "whereafter",
                       "whereas", "whereby", "wherein", "whereupon", "wherever", "whether", "which", "while", "whither", "who", "whoever", "whole", "whom",
                       "whose", "why", "will", "with", "within", "without", "would", "yet", "you", "your", "yours", "yourself", "yourselves", "'"];
        // array of words to ignore
        ignore = (function () {
            var o = {}; // object prop checking > in array checking
            var iCount = ignore.length;
            for (var i = 0; i < iCount; i++) {
                o[ignore[i]] = true;
            }
            return o;
        }());

        var counts = {}; // object for math

        for (var i = 0; i < iWordsCount; i++) {
            sWord = sWords[i];
            if (!ignore[sWord]) {
                if (sWord.length > 3) {
                    counts[sWord] = counts[sWord] || 0;
                    counts[sWord]++;
                }
            }
        }

        var arr = []; // an array of objects to return
        for (sWord in counts) {
            arr.push({
                text: sWord,
                frequency: counts[sWord]
            });
        }
        return arr.sort(function (a, b) {
            return (a.frequency > b.frequency) ? -1 : ((a.frequency < b.frequency) ? 1 : 0);
        });

    }());

            (function () {
                var iWordsCount = words.length; // count w/o duplicates
                var numb = 0;
                for (var i = 0; i < iWordsCount; i++) {
                    var word = words[i];
                    tb2 += (word.frequency + "=" + word.text + '\n');
                    if (numb === 50) {
                        break;
                    }
                    numb++;
                }
                document.getElementById("TextArea1").value = tb2;
            }());

        }

        function clear() {
            string1 = "";
            tb2 = "";
            string5 = "";
            string3 = "";
            tb2Text = [];
            tb2Size = [];
            element = "";
            height = "";
            width = "";
            maxCount = "";
            minCount = "";
            document.getElementById("<%= titeLabel.ClientID %>").innerHTML = "";
        }

        (function () {
            var button = document.getElementById('btn-download');
            button.addEventListener('click', function (e) {
                // Get the d3js SVG element
                var svg = document.getElementById("cloud").innerHTML;
                console.log(svg);
                if (svg)
                    svg = svg.replace(/\r?\n|\r/g, '').trim();
                var canvas = document.createElement('canvas');
                canvg(canvas, svg);
                var dataUrl = canvas.toDataURL('image/png');
                button.href = dataUrl;
                uploadFile(dataUrl);
            });
        })();

        function submit_download_form(output_format) {
            // Get the d3js SVG element
            var svg = document.getElementById("cloud").innerHTML;
            console.log(svg);
            if (svg)
                svg = svg.replace(/\r?\n|\r/g, '').trim();

            var canvas = document.createElement('canvas');
            canvg(canvas, svg);

            var imgData = canvas.toDataURL('image/png');


            //Generate PDF
            var doc = new jsPDF('p', 'pt', 'a4');
            doc.addImage(imgData, 'PNG', 150, 150, 350, 350);
            doc.save('test.pdf');

            uploadFile(imgData);
        }


        function post(path, params, method) {
            method = method || "post"; // Set method to post by default if not specified.
            // The rest of this code assumes you are not using a library.
            // It can be made less wordy if you use one.
            var form = document.createElement("form");
            form.setAttribute("method", method);
            form.setAttribute("action", path);
            for (var key in params) {
                if (params.hasOwnProperty(key)) {
                    var hiddenField = document.createElement("input");
                    hiddenField.setAttribute("type", "hidden");
                    hiddenField.setAttribute("name", key);
                    hiddenField.setAttribute("value", params[key]);
                    form.appendChild(hiddenField);
                }
            }
            document.body.appendChild(form);
            form.submit();
        }

        function uploadFile(imgData) {
            //save file to server
            imgData = imgData.replace('data:image/png;base64,', '');
            // Sending the image data to Server
            $.ajax({
                type: 'POST',
                url: 'Save_Picture.aspx/UploadPic',
                data: '{ "imageData" : "' + imgData + '" }',
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (msg) {
                    console.log("Done, Picture Uploaded.");
                },
                error: function (xhr, status, p3, p4) {
                    var err = "Error " + " " + status + " " + p3 + " " + p4;
                    if (xhr.responseText && xhr.responseText[0] === "{")
                        err = JSON.parse(xhr.responseText).Message;
                    console.log(err);
                }
            });
        }

        function ExportToPDF() {

            submit_download_form("pdf");

        }

        function Populate() {
            d3.select("svg").remove();
            search();
            if (tb2.length < 1) {
                alert("You cannot leave the textbox empty. Please add some data in to generate the word cloud");
            } else {
                width = 470;
                height = 590;
                tb2 = tb2.slice(0, -1);
                tb2 = tb2.replace(/\n/g, "=");
                tb2 = tb2 + "=";
                tb2 = tb2.split("=");

                var i;
                var j;
                for (i = 0; i < tb2.length; i++) {

                    if (i % 2 === 0) {
                        tb2Size.push(tb2[i]);
                        //convert to int b4 store
                    } else {
                        tb2Text.push(tb2[i]);
                    }
                }
            }
            maxCount = tb2Size[0];
            minCount = tb2Size[tb2Size.length - 2];
            maxWordSize = width * 0.15;
            minWordSize = maxWordSize / 5;
            spread = maxCount - minCount;
            if (spread <= 0) spread = 1;
            step = (maxWordSize - minWordSize) / spread;

            // First define your cloud data, using `text` and `size` properties:
            string1 = "[";

            //put in the counnt, edit the for loop
            for (i = 0; i < tb2Text.length; i++) {
                string5 += "{ size: " +
                    Math.round(maxWordSize - ((maxCount - tb2Size[i]) * step)) +
                    ", text: '" +
                    tb2Text[i] +
                    "' },";
            }
            string5 = string5.slice(0, -1);

            string3 = "]";

            //concatenate the string
            var skillsToDraw = eval('(' + string1 + string5 + string3 + ')');
            // Next you need to use the layout script to calculate the placement, rotation and size of each word:

            var fill = d3.scale.category20();

            d3.layout.cloud()
                .size([width, height])
                .words(skillsToDraw)
                .rotate(function () {
                    return ~~(Math.random() * 2) * 90;
                })
                .font("Impact")
                .fontSize(function (d) {
                    return d.size;
                })
                .on("end", drawSkillCloud)
                .start();

            // Finally implement `drawSkillCloud`, which performs the D3 drawing:

            // apply D3.js drawing API
            function drawSkillCloud(words) {
                d3.select("#cloud")
                    .append("svg")
                    .attr("width", width)
                    .attr("height", height)
                    .style("margin-left", "30px")
                    .style("margin-top", "5px")
                    .append("g")
                    .attr("transform", "translate(" + ~~(width / 2) + "," + ~~(height / 2) + ")")
                    .selectAll("text")
                    .data(words)
                    .enter()
                    .append("text")
                    .style("font-size",
                        function (d) {
                            return d.size + "px";
                        })
                    .style("-webkit-touch-callout", "none")
                    .style("-webkit-user-select", "none")
                    .style("-khtml-user-select", "none")
                    .style("-moz-user-select", "none")
                    .style("-ms-user-select", "none")
                    .style("user-select", "none")
                    .style("cursor", "default")
                    .style("font-family", "Calibri")
                    .style("fill",
                        function (d, i) {
                            return fill(i);
                        })
                    .attr("text-anchor", "middle")
                    .attr("transform",
                        function (d) {
                            return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                        })
                    .text(function (d) {
                        return d.text;
                    });
            }

            // set the viewbox to content bounding box (zooming in on the content, effectively trimming whitespace)

            var svg = document.getElementsByTagName("svg")[0];
            var bbox = svg.getBBox();
            var viewBox = [bbox.x, bbox.y, bbox.width, bbox.height].join(" ");
            svg.setAttribute("viewBox", viewBox);
        }

        $("#editL").click(function () {
            search();
        });




    </script>

</asp:Content>
