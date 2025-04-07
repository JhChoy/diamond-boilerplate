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

        counter = ICounterApp(deploy(abi.encode(msg.sender), salt, facetNames, facetArgs, address(0), "").diamond);
    }

    function upgrade() public broadcast {
        facetNames.push("CounterFacet");
        facetArgs.push("");

        upgrade(facetNames, facetArgs, address(0), "");
    }
}
```
1. Inherit from `DiamondScript` and pass the `"DiamondApp"` contract name to the constructor.
2. Use `deploy` function to deploy diamond and facets by providing:
   - `args`: Initialization arguments for the diamond
   - `salt`: Salt for deterministic address generation
   - `facetNames`: List of facet contract names
   - `facetArgs`: List of encoded constructor arguments for each facet
   - `initContract`: Optional initialization contract address
   - `initData`: Optional initialization data
   - The deployment will automatically save the addresses in `deployments/${diamondName}.${network}.json`
   - All external functions in these Facets will be registered
3. Upgrade `DiamondApp` using `upgrade` function with:
   - `facetNames`: List of facet contract names
   - `facetArgs`: List of encoded constructor arguments for each facet
   - `initContract`: Optional initialization contract address
   - `initData`: Optional initialization data
   - This requires an existing deployment file in `deployments/${diamondName}.${network}.json`
   - The upgrade will automatically save the new addresses in the deployment file
   - The app will be upgraded with all external functions from the specified Facets
   - If a facet is not in the new list, its functions will be removed
   - If a facet is updated, its functions will be replaced
   - If a facet is new, its functions will be added


## Contribution
All contributions are welcome

## License
MIT
