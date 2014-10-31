library plato.paper.association_maker;

import 'dart:html';

import 'package:polymer/polymer.dart';
import 'package:crypto/crypto.dart' show MD5, CryptoUtils;

import 'package:paper_elements/paper_input.dart';
import 'package:paper_elements/paper_toast.dart';

/// The [PlatoAssociationMaker] class is a Polymer based element.
@CustomTag('plato-association-maker')
class PlatoAssociationMaker extends PolymerElement {
  @observable String itemId = '';
  @observable String nodeId = '';
  @observable String associationKey;

  PlatoAssociationMaker.created() : super.created() {}

  /// The [handleItemIdChange] and [handleNodeIdChange] methods help as a workaround
  /// for a bug within the [paper_elements] package, whereby two-way data binding is
  /// not correctly updated.
  void handleItemIdChange() {
    itemId = ($['itemIdInput'] as PaperInput).value;

    if ((2 < itemId.length) && ('wsu' != itemId.substring (0, 3))) {
      nodeId = 'wsu-node';
    }
  }

  String handleNodeIdChange() => nodeId = ($['nodeIdInput'] as PaperInput).value;

  /// The [makeAssociationKey] method takes the information provided from the section
  /// or user ID and node ID, along with a formatted timestamp, to create an MD5
  /// hash for the section or user to node association key.
  void makeAssociationKey() {
    if (0 == itemId.length || 0 == nodeId.length) {
      PaperToast noAssociationToast = $['associationToast'] as PaperToast
        ..text = "Both the section/user and node ID\'s must have values."
        ..show();

      return;
    }

    String timestamp = new DateTime.now().toString();

    MD5 associationHasher = new MD5()
      ..add ('$nodeId:$itemId:$timestamp'.codeUnits);

    associationKey = CryptoUtils.bytesToHex (associationHasher.close());

    ($['association-key-text'] as SpanElement).style
      ..display = 'block'
      ..transition = '0.5s ease-in-out';
  }
}
