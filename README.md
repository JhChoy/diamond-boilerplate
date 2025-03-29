# Diamond Boilerplate
Boilerplate code using [diamond library](https://github.com/JhChoy/diamond)(Diamond + CreateX).

## Getting Started

### Installation
```
git clone https://github.com/JhChoy/diamond-boilerplate
cd diamond-boilerplate
forge install
```

### Build
```
forge compile
```

### Test
```
forge test
```

### Lint
```
forge fmt
```


## How to develop with this framework?
### Storages
Define storages following [EIP-1967](https://eips.ethereum.org/EIPS/eip-1967) format in `src/storages/` (See [Count.sol](./src/storages/Count.sol) for example)

### Facets
Define Facets to be included in the Diamond App in `src/facets/`

NOTE: Only use storages defined in `src/storages`. Using conventional storage definitions may cause storage conflicts.

### App
Define your app by inheriting from `DiamondApp`, like the example `CounterApp.sol`. As with Facets, be careful not to use conventional storage definitions.

### Interfaces
Define interfaces in `src/interfaces`. You can easily define all interfaces for your app by inheriting from `IDiamondApp` and other facet interfaces, as shown in `ICounterApp`.

## How to deploy/upgrade?
See below [Counter.s.sol](/script/Counter.s.sol).
```solidity
contract CounterScript is DiamondScript("CounterApp") {
    ...

    function deploy() public broadcast {
        facetNames.push("CounterFacet");
        facetArgs.push("");

        counter = ICounterApp(deployAndSave(abi.encode(address(this)), facetNames, facetArgs).diamond);
    }

    function upgrade() public broadcast {
        facetNames.push("CounterFacet");
        facetArgs.push("");

        upgradeToAndSave(facetNames, facetArgs);
    }
}
```
1. Inherit from `DiamondScript` and pass the `"DiamondApp"` contract name to the constructor.
2. Use `deploy` or `deployAndSave` function to deploy diamond and facets by providing a list of facet contract names and their encoded constructor arguments
    - `deployAndSave` stores the addresses of the app and facet list in `deployments/${diamondName}.${network}.json` after deployment
    - All external functions in these Facets will be registered
3. Upgrade `DiamondApp` using `upgradeTo` or `upgradeToAndSave` functions
    - This requires an existing deployment file. If not available, you can build the deployment json manually and pass it as the first argument to `upgradeTo(string,string[],bytes[])`
    - `upgradeToAndSave` stores the addresses of the app and facet list in `deployments/${diamondName}.${network}.json` after deployment
    - The app will be upgraded with all external functions from the specified Facets


## Contribution
All contributions are welcome

## License
MIT
