module.exports = {
  networks: {
    development: {
      host: 'localhost',
      port: 8545,
      network_id: '*' // Match any network id
    },
    test: {
      host: '127.0.0.1',
      port: 8546,
      network_id: 1234321
    }
  },
  plugins: [
    'truffle-plugin-modularizer'
  ],
  modularizer:
    {
      output: 'src/index.js',
      target: 'build/contracts',
      includeOnly: [
        'CodeEatingHippo'
      ], // if you don\'t configure includeOnly property, it will save all contracts
      networks: [
        1,
        2
      ] // if you don\'t configure networks property, it will save all networks
    }
}
