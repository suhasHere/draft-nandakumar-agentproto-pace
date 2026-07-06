DRAFT = draft-nandakumar-ai-agent-moq-transport.md
LIBDIR := ../moq-transport/lib
include $(LIBDIR)/main.mk

# Preserve XML files - do not delete them as intermediates or during clean
.PRECIOUS: %.xml
.SECONDARY: %.xml
