# Makefile for MCP over MOQT Internet Draft
#
# This Makefile generates TXT and HTML formats from the kramdown-rfc markdown source
# Requires: kramdown-rfc2629 gem and xml2rfc tool

# Variables
DRAFT_NAME = draft-a2a-moqt-transport
SOURCE = $(DRAFT_NAME).md
XML_FILE = $(DRAFT_NAME).xml
TXT_FILE = $(DRAFT_NAME).txt
HTML_FILE = $(DRAFT_NAME).html

# Default target
all: txt html 

# Generate XML from markdown
$(XML_FILE): $(SOURCE)
	kramdown-rfc2629 $(SOURCE) > $(XML_FILE)


# Generate TXT from XML
txt: $(TXT_FILE)

$(TXT_FILE): $(XML_FILE)
	xml2rfc --text $(XML_FILE)

# Generate HTML from XML  
html: $(HTML_FILE)

$(HTML_FILE): $(XML_FILE)
	xml2rfc --html $(XML_FILE)

# Clean generated files
clean:
	rm -f $(XML_FILE) $(TXT_FILE) $(HTML_FILE) 

# Validate XML
validate: $(XML_FILE) $(SECURE_XML_FILE)
	@echo "Validating XML..."
	xml2rfc --validate $(XML_FILE)


# Declare phony targets
.PHONY: all txt html clean 

pdf: $(XML_FILE)
	xml2rfc --pdf $(XML_FILE)
