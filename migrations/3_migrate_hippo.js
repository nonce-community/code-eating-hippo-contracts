const CodeEatingHippo = artifacts.require('./CodeEatingHippo.sol')
const LibHippo = artifacts.require('./LibHippo.sol')

module.exports = function (deployer) {
  deployer.link(LibHippo, CodeEatingHippo)
  deployer.deploy(CodeEatingHippo)
}
