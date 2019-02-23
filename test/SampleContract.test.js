const chai = require('chai')
const BigNumber = web3.BigNumber
chai.use(require('chai-bignumber')(BigNumber)).should()
const SampleContract = artifacts.require('SampleContract')
chai.use(require('chai-bignumber')(BigNumber)).should()

contract('SampleContract', ([deployer, ...members]) => {
  let sampleContract
  context('Test', async () => {
    beforeEach('Deploy new contract', async () => {
      sampleContract = await SampleContract.new()
    })
    describe('add()', async () => {
      it('should return added values as an array', async () => {
        await sampleContract.add(10)
        await sampleContract.add(20)
        await sampleContract.add(30)
        let storedValues = await sampleContract.getValues()
        storedValues[0].toNumber().should.equal(10)
        storedValues[1].toNumber().should.equal(20)
        storedValues[2].toNumber().should.equal(30)
      })
    })
  })
})
