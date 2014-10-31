part of plato.paper.utils;

class RequestInformation {
  /**
   * The singleton instance of [RequestInformation], containing.
   */
  static RequestInformation _instance;

  /**
   * The singleton instance of [UserInformation], which provides user context.
   */
  UserInformation _userInfo;

  /**
   * The [List] of requested [Section]s.
   */
  List<Section> _sections;

  /**
   * The [List] of requested [Sandbox]es.
   */
  List<Sandbox> _sandboxes;

  /**
   * The [List] of requested [CrossListing]; every [Section] in every [CrossListing]
   * must also be present in the [List] of requested [Section]s.
   */
  List<CrossListing> _crossListings;

  /**
   * The [List] of [LearnSectionCopy] instances; the requested [Section] instace
   * must also be present in the [List] of requested [Section]s.
   */
  List<LearnSectionCopy> _learnSectionCopies;

  /**
   * The [List] of [VistaSectionImport]s; the requested [Section] instance must
   * also be present in the [List] of requested [Section]s.
   */
  List<VistaSectionImport> _vistaSectionImports;

  /**
   * The [RequestInformation] factory constructor is used to retrieve the singleton
   * instance of this class, creating it if it has not already been created.
   */
  factory RequestInformation() {
    if (null == _instance) {
      _instance = new RequestInformation._internal();
    }

    return _instance;
  }

  /**
   * The [RequestInformation._internal] private constructor is called by the
   * factory constructor a single time, to create the singleton instance of this
   * class.  Fields are initalized during instantiation.
   */
  RequestInformation._internal() {
    _userInfo = new UserInformation();

    _sections = new List<Section>();
    _sandboxes = new List<Sandbox>();
    _crossListings = new List<CrossListing>();
    _learnSectionCopies = new List<LearnSectionCopy>();
    _vistaSectionImports = new List<VistaSectionImport>();
  }

  List<Section> get sections => _sections;
  List<Sandbox> get sandboxes => _sandboxes;
  List<CrossListing> get crossListings => _crossListings;
  List<LearnSectionCopy> get learnSectionCopies => _learnSectionCopies;
  List<VistaSectionImport> get vistaSectionImports => _vistaSectionImports;

  /**
   * The [addSection] method allows the addition of a [Section] instance to the
   * request information.  If the [Section] has already been added, an instance
   * of [RequestableException] will be thrown.
   */
  void addSection (Section aSection) {
    if (_sections.contains (aSection)) {
      throw new RequestableException (
        'Cannot add the same section to the request a second time.'
      );
    }

    _sections.add (aSection);
  }

  /**
   * The [removeSection] method allows the removal of a specific [Section] instance
   * from the request.  If the [Section] is not part of the request, an instance
   * of [RequestableException] will be thrown.
   */
  void removeSection (Section aSection) {
    if (!_sections.contains (aSection)) {
      throw new RequestableException (
        'Cannot remove a section from the request that was not previously added.'
      );
    }

    _sections.remove (aSection);
  }

  /**
   * The [addSandbox] method allows the addition of a [Sandbox] instance to the
   * request.  If the [Sandbox] has already been added, a [RequestableException]
   * instance will be thrown.
   */
  void addSandbox (Sandbox aSandbox) {
    if (_sandboxes.contains (aSandbox)) {
      throw new RequestableException (
        'Cannot add the same sandbox to the request a second time.'
      );
    }
  }

  /**
   * The [removeSandbox] method allows the removal of a specific [Sandbox] instance
   * from the request.  If the [Sandbox] is not part of the request, then an
   * instance of [RequestableException] will be thrown.
   */
  void removeSandbox (Sandbox aSandbox) {
    if (!_sandboxes.contains (aSandbox)) {
      throw new RequestableException (
        'Cannot remove a sandbox from the request that was not previously added.'
      );
    }

    _sandboxes.remove (aSandbox);
  }

  /**
   * The [addCrossListing] method allows the addition of a [CrossListing] instance
   * to the request.  If the instance was previously added, or if not every [Section]
   * instance within the [CrossListing] instance is part of the request, then
   * a [CrossListingException] instance will be thrown.
   */
  void addCrossListing (CrossListing aCrossListing) {
    if (_crossListings.contains (aCrossListing)) {
      throw new CrossListingException (
        'Cannot add a cross-listing set to the request a second time.'
      );
    }

    // If not every section within the cross-listing is part of the request, fail.
    if (!aCrossListing._sections.every (
      (Section section) => (_sections.contains (section)) ? true : false
    )) {
      throw new CrossListingException (
        'Cannot add a cross-listing containing sections not part of the request.'
      );
    }

    _crossListings.add (aCrossListing);
  }

  /**
   * The [removeCrossListing] method allows the removal of a specific instance
   * of [CrossListing] from the request.  If it was not a part of the request,
   * then a [CrossListingException] instance will be thrown.
   */
  void removeCrossListing (CrossListing aCrossListing) {
    if (!_crossListings.contains (aCrossListing)) {
      throw new CrossListingException (
        'Cannot remove a cross-listing that was not previously added.'
      );
    }

    _crossListings.remove (aCrossListing);
  }

  /**
   * The [addLearnSectionCopy] method allows the addition of a [LearnSectionCopy]
   * instance to the requst.  Should the instance have already been added, or if
   * its requested [Requestable] instance not be a part of the request, then a
   * [PreviousContentException] instance will be thrown.
   */
  void addLearnSectionCopy (LearnSectionCopy aLearnSectionCopy) {
    if (_learnSectionCopies.contains (aLearnSectionCopy)) {
      throw new PreviousContentException (
        'Cannot add a previous Learn section copy a second time.'
      );
    }

    if (!_sections.contains (aLearnSectionCopy.requested)) {
      throw new PreviousContentException (
        'Cannot add a previous Learn section copy for a section not part of the request.'
      );
    }

    _learnSectionCopies.add (aLearnSectionCopy);
  }

  /**
   * The [removeLearnSectionCopy] method allows the removal of a specific instance
   * of [LearnSectionCopy] from the request.  If it is not part of the request,
   * then a [PreviousContentException] instance will be thrown.
   */
  void removeLearnSectionCopy (LearnSectionCopy aLearnSectionCopy) {
    if (!_learnSectionCopies.contains (aLearnSectionCopy)) {
      throw new PreviousContentException (
        'Cannot remove a previous Learn section copy that was not previously added.'
      );
    }

    _learnSectionCopies.remove (aLearnSectionCopy);
  }

  /**
   * The [addVistaSectionImport] method allows the addition of a [VistaSectionImport]
   * instance to the request.  Should the instance have already been added, or if
   * its requested [Requestable] instance not be a part of the request, then a
   * [PreviousContentException] instance will be thrown.
   */
  void addVistaSectionImport (VistaSectionImport aVistaSectionImport) {
    if (_vistaSectionImports.contains (aVistaSectionImport)) {
      throw new PreviousContentException (
        'Cannot add a previous Vista section import a second time.'
      );
    }

    if (!_sections.contains (aVistaSectionImport.requested))  {
      throw new PreviousContentException (
        'Cannot add a previous Vista section import for a section not part of the request.'
      );
    }

    _vistaSectionImports.add (aVistaSectionImport);
  }

  /**
   * The [removeVistaSectionImport] method allows the removal of a specific instance
   * of [VistaSectionImport] from the request.  If it is not part of the request,
   * then a [PreviousContentException] instance will be thrown.
   */
  void removeVistaSectionImport (VistaSectionImport aVistaSectionImport) {
    if (!_vistaSectionImports.contains (aVistaSectionImport)) {
      throw new PreviousContentException (
        'Cannot remove a previous Vista section import that was not previously added.'
      );
    }

    _vistaSectionImports.remove (aVistaSectionImport);
  }

  /**
   * The [toJson] method outputs a JSON-based [String] representation of the
   * request information reflected by this class.
   */
  String toJson() {
    Map requestJson = new Map()
      ..['userInfo'] = _userInfo
      ..['sections'] = _sections
      ..['sandboxes'] = _sandboxes
      ..['crossListings'] = _crossListings
      ..['learnSectionCopies'] = _learnSectionCopies
      ..['vistaSectionImports'] = _vistaSectionImports;

    return JSON.encode (requestJson);
  }
}
