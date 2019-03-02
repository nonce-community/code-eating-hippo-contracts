const chai = require('chai')
const BigNumber = web3.BigNumber
chai.use(require('chai-as-promised')).use(require('chai-bignumber')(BigNumber)).should()
const expect = chai.expect

const CodeEatingHippo = artifacts.require('CodeEatingHippo')

contract('CodeEatingHippo', ([deployer, ...participants]) => {
  let codeEatingHippo
  context('Test', async () => {
    beforeEach('Deploy new contract', async () => {
      codeEatingHippo = await CodeEatingHippo.deployed()
    })
    describe('createHippo()', async () => {
      it('should create a new hippo with ipfs uri and max number of clones', async () => {
        await codeEatingHippo.createHippo('ipfssampleUri', 100, { from: deployer })
      })
      it('should be rejected when non-admin account tries to call', () => {
        return expect(codeEatingHippo.createHippo(
          'ipfssampleUri', 100, { from: participants[0] }
        )).to.be.rejected
      })
      it('should be rejected when the DNA already exists', () => {
        // DNA is decided by the ipfs uri
        return expect(codeEatingHippo.createHippo(
          'ipfssampleUri', 200, { from: deployer }
        )).to.be.rejected
      })
    })
    describe('cloneHippo()', async () => {
    })
  })
})
