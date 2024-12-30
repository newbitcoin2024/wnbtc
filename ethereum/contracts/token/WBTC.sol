// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NBTC is ERC20, ERC20Burnable, ERC20Pausable, Ownable {
    constructor() ERC20("Wrapped NBTC", "NBTC") Ownable(msg.sender) {
        _mint(msg.sender, 0); // Initial supply is set to 0
    }

    /**
     * @dev Fonction de mint accessible uniquement au propriétaire.
     */
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    /**
     * @dev Fonction de burn accessible uniquement au propriétaire.
     */
    function burn(uint256 amount) public override onlyOwner {
        super.burn(amount);
    }

    /**
     * @dev Bloquer la renonciation à la propriété.
     */
    function renounceOwnership() public view override onlyOwner {
    revert("Renouncing ownership is blocked");
}

    /**
     * @dev Mettre en pause le contrat.
     */
    function pause() public onlyOwner {
        _pause();
    }

    /**
     * @dev Réactiver le contrat.
     */
    function unpause() public onlyOwner {
        _unpause();
    }

    /**
     * @dev Surcharge de la fonction `_update` pour résoudre le conflit.
     */
    function _update(address from, address to, uint256 value)
        internal
        virtual
        override(ERC20, ERC20Pausable)
    {
        super._update(from, to, value); // Appel à la version avec `whenNotPaused`
    }
}
