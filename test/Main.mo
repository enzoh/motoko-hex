/**
 * Module      : Main.mo
 * Description : Unit tests.
 * Copyright   : 2020 DFINITY Stiftung
 * License     : Apache 2.0 with LLVM Exception
 * Maintainer  : Enzo Haussecker <enzo@dfinity.org>
 * Stability   : Stable
 */

import Array "mo:base/Array";
import Hex "../src/Hex";
import Prelude "mo:base/Prelude";
import Result "mo:base/Result";

actor {

  private type Result<Ok, Err> = Result.Result<Ok, Err>;

  private func eq(a : Nat8, b : Nat8) : Bool {
    a == b;
  };

  private func unwrap(result : Result<[Nat8], Hex.DecodeError>) : [Nat8] {
    switch (result) {
      case (#ok blob) blob;
      case (#err err) Prelude.unreachable();
    }
  };

  public func run() {
    let data : [Nat8] = [
      072, 101, 108, 108, 111, 032, 087, 111,
      114, 108, 100,
    ];
    let expect = #ok data;
    let actual = Hex.decode(Hex.encode(data));
    assert(Array.equal<Nat8>(unwrap(expect), unwrap(actual), eq));
  };
};
