-- treesitter parser is 'qmljs'; register it for the 'qml' filetype
require('ftsetup').setup({ parser = 'qmljs', server = 'qmlls' })
