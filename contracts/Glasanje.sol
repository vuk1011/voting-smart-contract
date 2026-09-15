// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Glasanje
/// @notice Lista kandidata je fiksna, može se postaviti prilikom deplozment-a.
///         Svaka adresa može glasati najviše jedanput i svi mogu pratiti rezultate uživo.
contract Glasanje {
    struct Kandidat {
        string ime;
        uint256 brGlasova;
    }

    Kandidat[] public kandidati;
    mapping(address => bool) public jeGlasao;

    event Glasao(
        address indexed glasac,
        uint256 indexed kandidatIndeks,
        string kandidatIme
    );

    /// @param imenaKandidata Niz imena kandidata, npr. ["Miloš", "Una", "Filip"].
    constructor(string[] memory imenaKandidata) {
        require(imenaKandidata.length >= 2, "Potrebno je bar 2 kandidata.");

        for (uint256 i = 0; i < imenaKandidata.length; i++) {
            kandidati.push(Kandidat({ime: imenaKandidata[i], brGlasova: 0}));
        }
    }

    /// @notice Dajte Vaš glas kandidatu po indeksu.
    /// @param kandidatIndeks Indeks u nizu kandidata.
    function vote(uint256 kandidatIndeks) external {
        require(!jeGlasao[msg.sender], unicode"Već ste glasali!");
        require(
            kandidatIndeks < kandidati.length,
            unicode"Loš indeks kandidata!"
        );

        jeGlasao[msg.sender] = true;
        kandidati[kandidatIndeks].brGlasova += 1;

        emit Glasao(msg.sender, kandidatIndeks, kandidati[kandidatIndeks].ime);
    }

    /// @notice Koliko kandidata učestvuje.
    function brojKandidata() external view returns (uint256) {
        return kandidati.length;
    }

    /// @notice Vrati ime i broj glasova kandidata po indeksu.
    function vratiKandidata(
        uint256 kandidatIndeks
    ) external view returns (string memory ime, uint256 brGlasova) {
        require(
            kandidatIndeks < kandidati.length,
            unicode"Loš indeks kandidata!"
        );
        Kandidat storage c = kandidati[kandidatIndeks];
        return (c.ime, c.brGlasova);
    }

    /// @notice Vrati indeks i ime kandidata koji trenutno vodi.
    ///         Ako je između nekih kandidata nerešeno, vrati prvog pronađenog.
    function winningCandidate()
        external
        view
        returns (uint256 pobednikIndeks, string memory pobednikIme)
    {
        uint256 highestVotes = 0;
        for (uint256 i = 0; i < kandidati.length; i++) {
            if (kandidati[i].brGlasova > highestVotes) {
                highestVotes = kandidati[i].brGlasova;
                pobednikIndeks = i;
            }
        }
        pobednikIme = kandidati[pobednikIndeks].ime;
    }
}
