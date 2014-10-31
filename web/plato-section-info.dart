library plato.paper.section_info;

import 'dart:html';

import 'package:polymer/polymer.dart';

import 'package:core_elements/core_item.dart';
import 'package:core_elements/core_menu.dart';
import 'package:core_elements/core_overlay.dart';

import './lib/utils/plato_paper_utils.dart' show Section;

/// A Polymer-based element, using paper elements, to display section info for
/// those which are to be created within Plato.
@CustomTag('plato-section-info')
class PlatoSectionInfo extends PolymerElement {
  @observable String section;
  @observable String number;
  @observable String title;
  @observable String department;
  @observable String instructor;
  @observable String time;
  @observable String term;

  /// An instance of [Section] serving as the data model for this custom element.
  Section _section;

  PlatoSectionInfo.created() : super.created();

  /// The [setSectionInformation] method is used to set a [Section] instance that
  /// holds the information for the section.
  void setSectionInformation (Section sectionInfo) {
    _section = sectionInfo;

    section = sectionInfo.section;
    number = sectionInfo.number;
    title = sectionInfo.title;
    department = sectionInfo.department;
    instructor = sectionInfo.instructor;
    time = sectionInfo.time;
    term = sectionInfo.term;
  }

  /// The [openSectionInfoMenu] method is used to open the contextual menu for
  /// the course section this custom element represent.
  void openSectionInfoMenu() =>
    ($['section-info-menu-overlay'] as CoreOverlay).open();

  /// The [onSectionMenuSelect] method is called when a user selects one of the
  /// items in the contextual menu.  It fires the associated event for the item
  /// as follows:
  ///
  /// 'cross-list-section':  cross-listing this section with another.
  /// 'copy-learn-content':  copying previous Learn content for this section.
  /// 'import-vista-content':  importing previous Vista content for this section.
  /// 'close-section-info':  removing this custom element from the DOM.
  void onSectionMenuSelect (Event event, var detail, Element target) {
    CoreMenu sectionInfoMenu = ($['section-info-menu'] as CoreMenu);
    CoreItem selectedItem = sectionInfoMenu.selectedItem;

    String eventName = null;

    switch ((sectionInfoMenu.selectedItem as CoreItem).icon) {
      case 'done-all': eventName = 'cross-list-section'; break;
      case 'content-copy': eventName = 'copy-learn-content'; break;
      case 'inbox': eventName = 'import-vista-content'; break;
      case 'remove-circle-outline': eventName = 'close-section-info'; break;
      default: return;
    }

    this.fire (eventName, detail: {'section': _section, 'term': term});
  }
}
