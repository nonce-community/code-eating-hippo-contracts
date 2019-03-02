const LibHippo = artifacts.require('./LibHippo.sol')

module.exports = function (deployer) {
  deployer.deploy(LibHippo)
}
