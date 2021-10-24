# createnft-solidity-ton

Смарт-контракт для выполнения в TVM FreeTON, написанный на языке Solidity. Содержит базовый функционал для создания NFT и последующей продажи токенов этого типа.

Для запуска:

    tondev sol compile Contract.sol
    tondev contract deploy Contract.sol -v 987654321334
    tondev contract run Contract
