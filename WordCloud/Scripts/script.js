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

function onFileSelected(event) {
    var selectedFile = event.target.files[0];
    var reader = new FileReader();

    reader.onload = function (event) {
        result.innerHTML = event.target.result;
        document.getElementById("TextArea1").value = " ";
    };

    reader.readAsText(selectedFile);
}


document.getElementById("sampleTitledropdown").onchange = function () {

    clear();
    width = 470;
    height = 590;
    titleLbl.innerHTML = " ";


    if (this.value === "computing") {
        //do this function
        tb2 = "JavaScript=80,D3js=30,coffeescript=50,Geolocation=50,AngularJS=60,Ruby=60,ECMAScript=30,Actionscript=20,Linux=40,canvas=40,audio=30,video=25,XMLHttpRequest=40,HTML=50,JAVA=76,JSONparse=76";

        titleLbl.innerHTML = "Title : Computing";
        gen();
    }
    else if (this.value === "finance") {
        //do this function
        tb2 = "Financial=80,Crisis=30,Economy=50,Government=50,Loan=60,Sanction=60,Depression=30,Stock=20,Market=40,Bank=40,Broker=30,Quarter=25,Profit=40,Loss=50,Global=76,Finance=76";

        titleLbl.innerHTML = "Title : Finance";
        gen();
    }
    else if (this.value === "politics") {
        //do this function
        tb2 = "Corrupt=80,Officials=30,Vote=50,Politicians=50,Elections=60,Veto=60,Congress=30,Labor=20,Voting=40,Senate=40,Official=30,Secretery=25,Treasurer=40,Whitehouse=50,Parliament=76,Save=46";

        titleLbl.innerHTML = "Title : Politics";
        gen();

    }
    else if (this.value === "vehicles") {

        tb2 = "Audi=80,Volvo=30,Car=50,Truck=50,Wheels=60,Manual=60,Auto=30,Highway=20,Speeding=40,Convertible=40,Cycle=30,Rental=25,Nissan=40,Jaguar=50,Expensive=76,Fast=76";

        titleLbl.innerHTML = "Title : Vehicles";
        gen();
    }
    else {
        WordCloud($('#wordCloud')[0], {
            list: [],
            classes: 'wordCloud',
            wait: 30,
            shape: shape,
            gridSize: 10,
            weightFactor: 1.6,
            fontFamily: 'Hiragino Mincho Pro, serif',
            color: 'random-dark',
            backgroundColor: '#FFFFFF',
            rotateRatio: 0
        });
    }
};

function gen() {

    tb2 = tb2.replace(/,/g, "=");
    tb2 = tb2.split("=");

    var i;
    var j;
    for (i = 0; i < tb2.length; i++) {

        if (i % 2 === 1) {
            tb2Size.push(tb2[i]);
            //convert to int b4 store
        } else {
            tb2Text.push(tb2[i]);
        }
    }

    maxCount = 80;
    minCount = 20;
    maxWordSize = width * 0.15;
    minWordSize = maxWordSize / 5;
    spread = maxCount - minCount;
    if (spread <= 0) spread = 1;
    step = (maxWordSize - minWordSize) / spread;

    // First define your cloud data, using `text` and `size` properties:
    var words = new Array();
    //put in the counnt, edit the for loop
    for (i = 0; i < tb2Text.length; i++) {
        words.push([
            tb2Text[i]
            ,
            Math.round(maxWordSize - ((maxCount - tb2Size[i]) * step))
        ]);
    }
    //generate
    //custom shape
    var selectShape = Math.floor((Math.random() * 5) + 1);
    var shape;
    if (selectShape == '1') {
        shape = 'circle';
    } else if (selectShape == '2') {
        shape = 'star';
    } else if (selectShape == '3') {
        shape = 'pentagon';
    } else if (selectShape == '4') {
        shape = 'diamond';
    } else if (selectShape == '5') {
        shape = 'triangle';
    }
    WordCloud($('#wordCloud')[0], {
        list: words,
        classes: 'wordCloud',
        wait: 30,
        shape: shape,
        gridSize: 10,
        weightFactor: 1.6,
        fontFamily: 'Hiragino Mincho Pro, serif',
        color: 'random-dark',
        backgroundColor: '#FFFFFF',
        rotateRatio: 0
    });
    // wordcloud result
    $(document).on('mouseenter', '.wordCloud', function () {
        var font_size = parseFloat($(this).css("font-size"));
        var newSize = font_size + 10;
        $(this).css("font-size", newSize + 'px');
    }).on('mouseout', '.wordCloud', function () {
        var font_size = parseFloat($(this).css("font-size"));
        var newSize = font_size - 10;
        $(this).css("font-size", newSize + 'px');
    });
}

function search() {
    clear();
    var words = (function () {

        var sWords = result.value.toLowerCase().trim().replace(/[,;:_=+^~*?%$&@#/\|\[\](){}<>!"1234567890.']/g, '\n').split(/[\s\/]+/g).sort();
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
    // document.getElementById("<%= titeLabel.ClientID %>").innerHTML = "";
}

(function () {
    var button = document.getElementById('btn-download');
    button.addEventListener('click', function (e) {
        var canvas = document.getElementById('wordCloud');
        var dataUrl = canvas.toDataURL('image/png');
        button.href = dataUrl;
        uploadFile(dataUrl);
    });
})();
$(function () {
    $('#updateButton').on('click', function () {
        search();
        go();
        if (tb2.length < 1) {
            alert("You cannot leave the textbox empty. Please add some data in to generate the word cloud");
        } else {
            width = 400;
            height = 500;
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
        var words = new Array();
        //put in the counnt, edit the for loop
        for (i = 0; i < tb2Text.length; i++) {
            words.push([
                tb2Text[i]
                ,
                Math.round(maxWordSize - ((maxCount - tb2Size[i]) * step))
            ]);
        }
        //generate

        //custom shape
        var selectShape = $('#shape').val();
        var shape;
        if (selectShape == '1') {
            shape = 'circle';
        } else if (selectShape == '2') {
            shape = 'star';
        } else if (selectShape == '3') {
            shape = 'pentagon';
        } else if (selectShape == '4') {
            shape = 'diamond';
        } else if (selectShape == '5') {
            shape = 'triangle';
        }
        WordCloud($('#wordCloud')[0], {
            list: words,
            classes: 'wordCloud',
            wait: 30,
            shape: shape,
            gridSize: 10,
            weightFactor: 1.6,
            fontFamily: 'Hiragino Mincho Pro, serif',
            color: 'random-dark',
            backgroundColor: '#FFFFFF',
            rotateRatio: 0
        });
    });
    // wordcloud result
    $(document).on('mouseenter', '.wordCloud', function () {
        var font_size = parseFloat($(this).css("font-size"));
        var newSize = font_size + 10;
        $(this).css("font-size", newSize + 'px');
    }).on('mouseout', '.wordCloud', function () {
        var font_size = parseFloat($(this).css("font-size"));
        var newSize = font_size - 10;
        $(this).css("font-size", newSize + 'px');
    });

});

function submit_download_form(output_format) {

    var canvas = document.getElementById('wordCloud');
    var imgData = canvas.toDataURL('image/png');

    //Generate PDF test
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


$("#editL").click(function () {
    search();
});


//Code for categorizing
var Bayes = (function (Bayes) {
    Array.prototype.unique = function () {
        var u = {}, a = [];
        for (var i = 0, l = this.length; i < l; ++i) {
            if (u.hasOwnProperty(this[i])) {
                continue;
            }
            a.push(this[i]);
            u[this[i]] = 1;
        }
        return a;
    }
    var stemKey = function (stem, label) {
        return '_Bayes::stem:' + stem + '::label:' + label;
    };
    var docCountKey = function (label) {
        return '_Bayes::docCount:' + label;
    };
    var stemCountKey = function (stem) {
        return '_Bayes::stemCount:' + stem;
    };

    var log = function (text) {
        console.log(text);
    };

    var tokenize = function (text) {
        text = text.toLowerCase().replace(/[,;:_=+^~*?%$&@#/\|\[\](){}<>!"1234567890.']/g, ' ').replace(/\s+/g, ' ').trim().split(' ').unique();

        return text;
    };

    var getLabels = function () {
        var labels = localStorage.getItem('_Bayes::registeredLabels');
        if (!labels) labels = '';
        return labels.split(',').filter(function (a) {
            return a.length;
        });
    };

    var registerLabel = function (label) {
        var labels = getLabels();
        if (labels.indexOf(label) === -1) {
            labels.push(label);
            localStorage.setItem('_Bayes::registeredLabels', labels.join(','));
        }
        return true;
    };

    var stemLabelCount = function (stem, label) {
        var count = parseInt(localStorage.getItem(stemKey(stem, label)));
        if (!count) count = 0;
        return count;
    };
    var stemInverseLabelCount = function (stem, label) {
        var labels = getLabels();
        var total = 0;
        for (var i = 0, length = labels.length; i < length; i++) {
            if (labels[i] === label)
                continue;
            total += parseInt(stemLabelCount(stem, labels[i]));
        }
        return total;
    };

    var stemTotalCount = function (stem) {
        var count = parseInt(localStorage.getItem(stemCountKey(stem)));
        if (!count) count = 0;
        return count;
    };
    var docCount = function (label) {
        var count = parseInt(localStorage.getItem(docCountKey(label)));
        if (!count) count = 0;
        return count;
    };
    var docInverseCount = function (label) {
        var labels = getLabels();
        var total = 0;
        for (var i = 0, length = labels.length; i < length; i++) {
            if (labels[i] === label)
                continue;
            total += parseInt(docCount(labels[i]));
        }
        return total;
    };
    var increment = function (key) {
        var count = parseInt(localStorage.getItem(key));
        if (!count) count = 0;
        localStorage.setItem(key, parseInt(count) + 1);
        return count + 1;
    };

    var incrementStem = function (stem, label) {
        increment(stemCountKey(stem));
        increment(stemKey(stem, label));
    };

    var incrementDocCount = function (label) {
        return increment(docCountKey(label));
    };

    Bayes.train = function (text, label) {
        registerLabel(label);
        var words = tokenize(text);
        var length = words.length;
        for (var i = 0; i < length; i++)
            incrementStem(words[i], label);
        incrementDocCount(label);
    };

    Bayes.guess = function (text) {
        var words = tokenize(text);
        var length = words.length;
        var labels = getLabels();
        var totalDocCount = 0;
        var docCounts = {};
        var docInverseCounts = {};
        var scores = {};
        var labelProbability = {};
        var wordicity;

        for (var j = 0; j < labels.length; j++) {
            var label = labels[j];
            docCounts[label] = docCount(label);
            docInverseCounts[label] = docInverseCount(label);
            totalDocCount += parseInt(docCounts[label]);
        }

        for (var j = 0; j < labels.length; j++) {
            var label = labels[j];
            var logSum = 0;
            labelProbability[label] = docCounts[label] / totalDocCount;

            for (var i = 0; i < length; i++) {
                var word = words[i];
                var _stemTotalCount = stemTotalCount(word);
                if (_stemTotalCount === 0) {
                    continue;
                } else {
                    var wordProbability = stemLabelCount(word, label) / docCounts[label];
                    var wordInverseProbability = stemInverseLabelCount(word, label) / docInverseCounts[label];
                    wordicity = wordProbability / (wordProbability + wordInverseProbability);

                    wordicity = ((1 * 0.5) + (_stemTotalCount * wordicity)) / (1 + _stemTotalCount);
                    if (wordicity === 0)
                        wordicity = 0.01;
                    else if (wordicity === 1)
                        wordicity = 0.99;
                }

                logSum += (Math.log(1 - wordicity) - Math.log(wordicity));
                log("Probability of " + word + " in " + label + " is:  " + wordicity);
            }
            scores[label] = 1 / (1 + Math.exp(logSum));
        }
        return scores;
    };

    Bayes.extractWinner = function (scores) {
        var bestScore = 0;
        var bestLabel = null;
        for (var label in scores) {
            if (scores[label] > bestScore) {
                bestScore = scores[label];
                bestLabel = label;
            }
        }
        return { label: bestLabel, score: bestScore };
    };

    return Bayes;
})(Bayes || {});

localStorage.clear();

var go = function go() {
    var text = result.value;
    var scores = Bayes.guess(text);
    var winner = Bayes.extractWinner(scores);
    titleLbl.innerHTML = "Title : " + winner.label;
    console.log(scores);
};

//No category
Bayes.train("", 'No Category');

// Finance Training
Bayes.train("account accounting accrue accumulate acquisition activity adjustable adjustment amex amortization annual annuity appraisal arbitrage arrangement arrears assets authentic authorization automated average averaging balance bank bankrupt barter bear beneficiary bid bond bracket broker brokerage bull buying buyout calculation call capital cartel cashier certificate certified chart churn circulation clearinghouse collateral collect commission commodity compensation competitor compound conglomerate consolidation consortium consumer convertible correction cost counter countersign credit currency custodian deal debenture debit debt deductible deduction default delinquency demand depository depreciation depression deregulation designation devaluation differential discount distribution diversify dividend downturn draft driven dump earn economy electronic elimination embezzlement endorse enterprise entity equity escrow esop estimation evaluation exceed exchange exorbitant expectation extortion failure federal fees fiduciary finance fiscal fixed float foreclosure forfeiture frugality fulfillment fund funds gain gdp gold government growth guarantee guaranty hiring identification illegal imprint income index industrial inflated insolvent installment institution insufficient intangible interest intermediary intervention invalidate investment iraissue kiting laundering lbo lending leverage liability lien liquidity loan long-term lucrative maintain margin market maturity member mercantile merger money monopoly municipals negotiable non-speculative note nyse obligation operation option overcompensate oversight ownership payment peaks percent planning pledge points portfolio practice predetermine premium principal product profit progressive public quality qualm quantity questionable quick quittance quote raid rally ramification rate ratio recession record recoup recourse redemption reduction regulation reimburse reliability reserves retirement risk rumors sale savings securities select selling shares shylock slump solvency speculate speculative split stagflation stock stocks subscription summary surety surplus survivorship swap takeover taxes technical tender thrifts trade transaction transfer transferable treasury trends uncollected underwriter unit unofficial unregulated unsecured untaxed usury utilities valuable value variable vault venture void voucher wage warrant wide-ranging withdrawal yield", 'Finance');

// Politics Training
Bayes.train("absentee accountable activist adverse advertising advice advise affiliation aggressive amendment announcement anthem appeal appearance appoint approach appropriation arguments articulate aspiration asset assimilation audience authorization background bait ballot bandwagon barnstorm behavior beliefs biannual bias bicameral bill bipartisan boondoggle brochure budget bunk bureaucracy cabinet campaign candidate canvass capitalize career catalyst caucus ceiling centrist challenge challenger changes charismatic choice citation civic coalition coattail collaboration colleague collective commitments committee commonality communication compassion concede concessions confidence congress congressional conscience consequence conservative constituent constitution consultation contribution controversy convene convention council curiosity cycle debate decision decisive declaration defeat deficit delegate deliberate deliberation democracy democrat democratic derision destiny diligent diplomat disapproval discourse discreet discussion disheartened dishonesty dissatisfaction district distrust diverse division dogma dominate donation donor dossier dynamic effective efficient elation elevate eloquence emphasis enact endorsement engaging equal ethics euphoria excessive executive experience faction federal feud filibuster flawed focus forum fraud freedom fundamental funding fundraiser gambit gerrymander glaring gop government grateful handshakes heckle historic honesty hooray hypocrisy immigrants impound inalienable incentive incorporate incumbency incumbent independent indulge infallible influx informative initiative innuendo inspiring integrity interests investigate involvement irresponsible issues jeopardy jubilant judge judicial keen knowledge landslide law leader leadership leanings legal legalization legislature liberal listening lobbyist lone loser loss loyalty magistrate majority mandate meaningful measures media meetings mentor minority misinformation motives mudslinging national nationwide negativity network nominate nominee nonpartisan obligation obsequious offensive office official opine opinion opinionated opportunity opposition orator outspoken ovation pamphlets pardon participation partisanship party patriotism petition platform pledge plurality polarize policy polite politician politics poll polling pollster popular popularity pragmatist praise precinct predictions prescient press pride primary priority proactive process progressive projection promises propaganda proponent proposal purpose query quest questions quorum quotes race ratify re-election reapportionment recall recognition reconciliation recount recrimination redistrict referendum reform registration regulate representation republican rescind resignation resilience restrictions retort reveal revelations revenues rhetoric runoff scope senate seniority shift shortcoming shuffle sidelines sinecure skill slate slogan solicitation solution spar spectacle speculate spending spin stakes stance statute strategist strategy stump subcommittee subjects success suffrage support system tactics tally taxpayer term ticket topic trust turnout ultimate unanimous uncommitted unfair uniformity unity unopposed unprecedented unwind upcoming upset vacancy veto viable victor victory vie viewpoint views violations vip volunteers voter vulnerability ward whistle-stop wild-card win winner withdraw withhold woo xenophobic yell yield zeal zealous zone aggression alliance autonomy blockade bullion casting vote census chronology circumnavigation citizen citizenship commonwealth consensus constituency consumer crusade culture mccarthyism currency curfew demagogue dependency depreciation of money despotic diarchy direct taxation domicile election electorate embassy emigrants emigration empire envoy excommunication exploitation ideology corruption exploration fanaticism fiduciary fief franchise freeholders guild hostage immigration impeachment muckraker imperialism independents indulgence inscription interdict interpellations jurisdiction mobocracy negotiation nomination ordinance renaissance squire tariffs tax temperance tenant tolls allegiance pundit sign signature states succession elector electoral college branch coattails tranquility treasury treason treaty war welfare write trial military monarchy framers nation negotiate oath people senatorial ratification regulation lobby representative republic responsibility revenue rights rule populace population power preamble president public jury legislate legislative liberty local justice defense document impeach duty civil constitutional country court amend army article assembly political politicians polity politically affairs politik intrigues policies motivations polices policymakers policy-making policymaking politica politique politico populism realpolitik geopolitics activism liberalism nationalism economics journalism conservatism diplomacy religion leftism partyism morality politicking politize regionalism demagoguery pragmatism politican psephology pols exclusionism parochialism politicalism cronyism bossism polemics parliamentarianism statesmanship factionalism electioneering idealism sectionalism statecraft establishmentarian revanchism elections statocracy cynicism debates neoconservativism reactionism sleaze pragmatics communalist superpolitic tribalism pettiness society social relation nativism machinations ultraism presidency metapolitics chauvinism ethnicism historiography lawmaking campaigning majoritarianism", 'Politics');

// Computing Training
Bayes.train("information technology binary computing javascript computational desktop computation software computers computer informatics digital cyber calculators processing design math edp calculator calculations arithmetic computerization electronic calculating equipment calculate calculation mechanization reckoning worksheet numeracy computerized calculated derivation estimating calculus calc determining icc estimation basis estimate recalculation computerised count counting compilation teams costing determination computerisation computerizing data-processing ict informatica informatique treatment mainframe multiprocessing supercomputer manageability workstation microprocessor netbook networked enterprise teraflop hardware autonomics server scalability bioinformatics parallelize notebooks laptops quadrics database wetware multimedia modius gigaflop cryptography somniloquy scalable sapir nanotechnology megaflops semiconductors interfaces processors bandwidth artificial intelligence applications parallelism boolean algebra groupware palmtop architecture smartphone ruggedization system firmware tool application compute programming programs packages adobe acrobat source package oss program programmes reader programme soft word agenda courseware open-source ready-made srx shareware antivirus isogon automation apps malware linux toolkit ecos synapta agentry programmers user interface coding systems functionality avast browser cyanea nessus disassembler extensible plugins coreid spooler plugin gantt chart summarizer trace applets utility programacclivity ebcdic migrator recode belight web assentor graphical station encryption wordprocessing propylon analytics tools programmer prototype readability alpha test adware asset baseline beta bill gates bot clipboard code review coder default demo documentation door downstream emulation end fork forking gimp hijack hijacking host icon implementation integration interfacing jukebox lotus macro malware manager menu oracle phase preferences program programme risk rootkit shell skin slacker spreadsheet spyware toolchain tutorial version virus vitus walkthrough william henry enl sponsor wordpad customer defect deliverable review growling netscape nudge nudging personalization showstopper sprint temperamental case verification accent accommodation acer acrostic ada adz adze alfalfa announcement announcer algorithms workflow cinematize metadata terminal undelete microcode eyebeam freeware debugging databases adrem app prebuilt scratchpad algorithm analog array backup bit bitmap bite blog blogger bookmark boot broadband buffer bug bus byte cache caps-lock captcha cd-rom client clipart cloudcomputing command compile compress configure cookie copy cybercrime cyberspace dashboard data datamining debug decompress delete development disk dns document domain dot download drag dynamic email emoticon encrypt enter exabyte file finder firewall flaming flash flashdrive floppydisk flowchart folder font format frame gigabyte graphics hack hacker homepage html hyperlink hypertext inbox integer internet ipaddress iteration java joystick junkmail kernel key keyboard keyword laptop laserprinter link login logout logic lurking media memory mirror modem monitor motherboard mouse net network node notebook offline online opensource operatingsystem option output page password paste path phishing piracy pirate platform plug-in podcast pop-up portal print printer privacy process protocol queue qwerty real-time reboot resolution restore root router runtime save scan scanner screen screenshot script scroll security shift snapshot social-networking spam spammer statusbar storage surf syntax table tag template terabyte thread toolbar trash trojan-horse typeface undo unix upload user-interface username url virtual webmaster website widget window wireless wiki worm www xml zip", 'Computing');

//Train for Stroke
Bayes.train("af-atrial fibrillation agnosia agraphia alexia amnesia aneurysm angioplasty aphagia aphasia apraxia ataxia asa-aspirin asd-atrial septal defect atheroma atherosclerosis avm-arterio-venous malformation bp-blood pressure brain attack brainstem bruit carotid arteries cd-carotid doppler endarterectomy cerebral haemorrhage cholesterol ct scan-computerised tomography scan cva-cerebrovascular accident contracture diplopia dysarthria dysphagia dyslexia dysphasia dysphonia dyspraxia eeg-electroencephalogram embolism hemianopia hemiparesis hemiplegia haematoma hbp-high blood hydrocephalus hypertension hypotension incontinence infarct ischaemia lacs-lacunar syndrome mid-multi-infarct dementia ng-naso-gastric nystagmus pacs-partial anterior circulation paralysis peg-percutaneous endoscopic gastrostomy pet-positive emission pocs-posterior sah-subarachnoid spasticity statin stroke tacs-total circulatory thalamus thrombolysis thrombosis tia-transient ischaemic vertigo vsd-ventricular warfarin abnormal acquired acute anemia arteriosclerosis artery aspirin atrial baseline blindness clot clots sugar blurred vision breathing cancer cardiovascular catheter cell chest pain x-ray compress craniotomy cva diabetes diagnosis dizziness ecg electrocardiogram emboli embolization emergency department headache heart disease hematocrit hemorrhage hemorrhagic high indicate infection kidney laboratory leg lipoprotein lips low lungs magnetic resonance imaging medical history neurologist onset oxygen peripheral physical therapy plaque pneumonia prognosis pulse rehabilitation skull sleep stent symptom tia tissue plasminogen activator tongue tpa unconscious urinalysis vein vessel white count leukocyte", 'Stroke');

//Train for Diabetes
Bayes.train("diabetes mellitus antibodies antigens autoantibodies carbohydrates dialysis diabetic ketoacidosis endocrine system fasting blood glucose glucagon hyperglycemia hypoglycemia ketones lipohyertrophy macrovascular microvascular nephropathy neuropathy pancreas protein retinopathy acetone acidosis advantame albuminuria autoimmune disorder insulin basal secretion level bolus acute adrenal glands adult-onset adverse effect alpha cell anomaly antidiabetic agent artery artificial aspartame asymptomatic atherosclerosis autoantibody test disease autonomic background rate beta biosynthetic monitoring testing pressure brittle urea nitrogen bun bunion callus calorie carbohydrate cardiologist cardiovascular certified educator cde cholesterol claudication coma dawn phenomenon dehydration dka dietitian emergency medical identification endocrinologist exchange lists plasma fpg fats fructose gangrene gastroparesis gestational glaucoma tolerance glycated hemoglobin hbac high sugar hormone human hypertension impotence injection site rotation sites insulin-dependent mixture pump reaction receptors resistance shock intermediate-acting intermittent jet injector juvenile-onset ketone bodies kidney nephropathy threshold lancet laser treatment late-onset lipid low metabolism mg/dl milligrams per deciliter mixed dose neurologist non-insulin dependent nutritionist obesity ophthalmologist optometrist oral medications peak action periodontal peripheral vascular pvd podiatrist polydipsia polyphagia polyunsaturated fat polyuria rapid-acting rebound regular renal retina risk factor saccharin self-blood short-acting somogyi sorbitol stevia sucrose sucralose sulfonylureas triglyceride type ulcer ultralente unit unstable urine urologist vaginitis vein vitrectomy xylitol", 'Diabetes');
