const Web3 = require('web3')
const chai = require('chai')
chai.use(require('chai-bignumber')()).should()

const { CodeEatingHippo } = require('../build/index.tmp')
const web3Provider = new Web3.providers.HttpProvider('http://localhost:8546')
const web3 = new Web3(web3Provider)

describe(
  'code-eating-hippo.js',
  () => {
    let accounts
    before(async () => {
      accounts = await web3.eth.getAccounts()
      web3.eth.defaultAccount = accounts[0]
    })
    context('Code Eating Hippo contract is deployed and use the contract with CodeEatingHippo(web3).deployed()', () => {
      let codeEatingHippo
      before(async () => { codeEatingHippo = await CodeEatingHippo(web3).deployed() })
      describe('createHippo()', async () => {
        it('should be able to create a new hippo with the admin account', async () => {
          await codeEatingHippo.createHippo('ipfssampleuri2', 50, { from: accounts[0] })
        })
      })
      describe('cloneHippo()', async () => {
        it('should be able to clone and send a hippo to a participant', async () => {
          let hippoDna = await codeEatingHippo.dnaList(0)
          await codeEatingHippo.cloneHippo(accounts[1], hippoDna)
        })
      })
      describe('getHippo()', async () => {
        it('should return the Hippo data with the hippo id', async () => {
          let hippoId = await codeEatingHippo.tokenOfOwnerByIndex(accounts[1], 0)
          let hippoData = await codeEatingHippo.getHippo(hippoId)
          hippoData._resUri.should.equal('ipfssampleuri2')
        })
      })
    })
  })
