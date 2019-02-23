# npm Truffle box

This is a boilerplate code to make your smart contract as an [npm](https://npmjs.com) library using [`truffle-plugin-modularizer`](https://github.com/wanseob/truffle-plugin-modularizer) . It exports the json files in `build/contracts/` and creates `src/index.js`. Then you will be able to use your contracts as an instance of [`truffle-contract`](https://github.com/trufflesuite/truffle/tree/develop/packages/truffle-contract). Finally, publish them onto the npm repository, and import into your applications. 

See [this](https://github.com/wanseob/truffle-plugin-modularizer) to get more detail how `truffle-plugin-modularize` works.



# Usage

### Contract side

1. Create a directory to start your project
	```bash
	mkdir YourProject
	cd YourProject
	```
	
2. Unbox `npm-truffle-box`
	```bash
	npx truffle unbox wanseob/npm-truffle-box
	```
	
3. Develop and test
	```bash
	npm run test
	```
	
4. Configure your truffle-config.json
	```javascript
    // truffle-config.js
    module.exports = {
      ...,
      plugins: [
        'truffle-plugin-modularizer'
      ],
      modularizer: {
        // output: 'src/index.js',
        // target: 'build/contracts'
        // includeOnly: [],
        // networks: []
      },
    }
   ```
   
5. Configure your package.json
	```javascript
	//package.json
	{
        "name": "Your project name",
        ...,
        "main": "src/index.js",
        ...
	}
	```
5. 	Deploy to npm
	```bash
	npm publish
	```

### Application side

1. install your module
	```bash
	$ cd /your/react/app/path
	$ npm install --save "your-project-name"
	```

2. Import contracts into your front-end application and init with web3 provider

	```javascript
    import { SampleContract } from 'your-project-name'

    web3 = window.web3
    
    SampleContract(web3).deployed().then(
        async instance => {
          await instance.add(10)
          await instance.add(20)
          await instance.add(30)
          let values = await instance.getValues()
          console.log("Values: ", values)
        }
    )
   ```



# Scripts

- `npm run testContracts`: It runs test cases in `test/` directory for your smart contracts. This uses `truffle test` command.
- `npm run testModule`: It runs test cases in `moduleTest/` to check the modularized output. It modularizes your contracts and create a temporal output file `build/index.tmp.js`. You should write Mocha test cases importing your smart contract from the temporal output file.
- `npm run test`: It tests both the contracts and the modularized output.
- `npm run standard`: It follows JS standard style.
- `npm run ethlint`: Lint your smart contracts.

If you don't prefer standard style and ethlint, remove "pre-commit" property from the `package.json` .



# Limitation

It only supports linux & macOS



# License

[Apache-2.0](LICENSE)
