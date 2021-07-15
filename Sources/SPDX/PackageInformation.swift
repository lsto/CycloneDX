/**
 3 Package Information
 If you organize your SPDX information by grouping into packages, then one instance of the
 Package Information is required per package being described. A package can contain subpackages, but the information in this section is a reference to the entire contents of the
 package listed. Starting with SPDX 2.0, it is not necessary to have a package wrapping a set
 of files.
 Cardinality: Optional, one or many.
 In tag:value format, the order in which package and files occur is syntactically significant.
 • A new Package Information section is denoted by the Package Name field.
 • All Package Information fields must be grouped together before the start of a Files
 section, if file(s) are present.
 • All files contained in a package must immediately follow the applicable Package
 Information.
 • A new Package Information section (via Package Name) denotes the start of another
 package.
 • Sub-packages should not be nested inside a Package Information section, but should
 be separate and should use a Relationship to clarify.
 • Annotations and Relationships for the package may appear after the Package
 Information before any file information.
 */
public struct PackageInformation {
    /**
     3.1 Package Name
     3.1.1 Purpose: Identify the full name of the package as given by the Package Originator.
     3.1.2 Intent: The name of each package is an important conventional technical identifier to
     be maintained for each package.
     3.1.3 Cardinality: Mandatory, one.
     3.1.4 Data Format: Single line of text.
     3.1.5 Tag: PackageName:
     Example:
     PackageName: glibc
     3.1.6 RDF: property spdx:name in class spdx:Package
     Example:
     <Package rdf:about="...">
      <name>glibc</name>
     </Package>
     */
    public var packageName: String

    /**
     3.2 Package SPDX Identifier
     3.2.1 Purpose: Uniquely identify any element in an SPDX document which may be
     referenced by other elements. These may be referenced internally and externally with the
     addition of the SPDX Document Identifier.
     3.2.2 Intent: There may be several versions of the same package within an SPDX document.
     Each element needs to be able to be referred to uniquely so that relationships between
     elements can be clearly articulated.
     3.2.3 Cardinality: Mandatory, one.
     3.2.4 Data Format: “SPDXRef-”[idstring]
     where [idstring] is a unique string containing letters, numbers, ., and/or -.
     3.2.5 Tag: SPDXID:
     Example:
     SPDXID: SPDXRef-1
     3.2.6 RDF: The URI for the element will follow the form:
     [SPDX DocumentNamespace]#[SPDX Identifier]
     See section 2.5 for the definition of the SPDX Document Namespace and section 2.3 for the
     definition of the SPDX Identifier
     Example using xml:base:
     <rdf:RDF xml:base="http://acme.com/spdxdocs/acmeproj/v1.2/1BE2A4FF-5F1A-48D3-
     8483-28A9B0349A1B">
      ...
      <Package rdf:about="#SPDXRef-1">
      ...
      </Package>
     </rdf:RDF>

     Example using document URI:
     <Package rdf:about="http://acme.com/spdxdocs/acmeproj/v1.2/1BE2A4FF-5F1A48D3-8483-28A9B0349A1B#SPDXRef-1">
      ...
     </Package>
     */
    public var packageSPDXIdentifier: String

    /**
     3.3 Package Version
     3.3.1 Purpose: Identify the version of the package.
     3.3.2 Intent: The versioning of a package is a useful for identification purposes and for
     indicating later changes of the package version.
     3.3.3 Cardinality: Optional, one.
     3.3.4 Data Format: Single line of text.
     3.3.5 Tag: PackageVersion:
     Example:
     PackageVersion: 2.11.1
     3.3.6 RDF: property spdx:versionInfo in class spdx:Package
     Example:
     <Package rdf:about="...">
      ...
      <versionInfo>2.11.1</versionInfo>
      ...
     </Package>
     */
    public var packageVersion: String?

    /**
     3.4 Package File Name
     3.4.1 Purpose: Provide the actual file name of the package, or path of the directory being
     treated as a package. This may include the packaging and compression methods used as
     part of the file name, if appropriate.
     3.4.2 Intent: The actual file name of the compressed file containing the package may be a
     significant technical element that needs to be included with each package identification
     information. If a grouping, like a set of files in a sub-directory, is being treated as a package,
     the sub-directory name may be appropriate to provide. Sub-directory name is preceded
     with a ./. See RFC 3986 for syntax.
     3.4.3 Cardinality: Optional, one.
     3.4.4 Data Format: Single line of text.
     3.4.5 Tag: PackageFileName:
     Example:
     PackageFileName: glibc-2.11.1.tar.gz
     Example (sub-directory being treated as a package):
     PackageFileName: ./myrootdir/mysubdir1

     3.4.6 RDF: property spdx:packageFileName in class spdx:Package
     Example:
     <Package rdf:about="...">
      ...
      <packageFileName>glibc 2.11.1.tar.gz</packageFileName>
      ...
     </Package>
     Example (sub-directory being treated as a package):
     <Package rdf:about="...">
      ...
      <packageFileName>./myrootdir/mysubdir1</packageFileName>
      ...
     </Package>
     */
    public var packageFileName: String?

    /**
     3.5 Package Supplier
     3.5.1 Purpose: Identify the actual distribution source for the package/directory identified
     in the SPDX file. This may or may not be different from the originating distribution source
     for the package. The name of the Package Supplier must be an organization or recognized
     author and not a web site. For example, SourceForge is a host website, not a supplier, the
     supplier for https://sourceforge.net/projects/bridge/ is “The Linux Foundation.”
     Use NOASSERTION if:
     (i) the SPDX file creator has attempted to but cannot reach a reasonable objective
     determination;
     (ii) the SPDX file creator has made no attempt to determine this field; or
     (iii) the SPDX file creator has intentionally provided no information (no meaning should be
     implied by doing so).
     3.5.2 Intent: Assist with understanding the point of distribution for the code in the
     package. This field is vital for ensuring that downstream package recipients can address
     any ambiguity or concerns that might arise with the information in the SPDX file or the
     contents of the package it documents.
     3.5.3 Cardinality: Optional, one.
     3.5.4 Data Format: Single line of text with the following keywords | NOASSERTION
     • Person: person name and optional (<email>)
     • Organization: organization name and optional (<email>)
     3.5.5 Tag: PackageSupplier:
     Example:
     SPDX Specification – Version 2.2
     Copyright 2010-2020 Linux Foundation and its Contributors. Licensed under CC-BY-3.0.
     27
     PackageSupplier: Person: Jane Doe (jane.doe@example.com)
     3.5.6 RDF: property spdx:supplier in class spdx:Package
     Example:
     <Package rdf:about="...">
      ...
      <supplier>Person: Jane Doe (jane.doe@example.com)</supplier>
      ...
     </Package>
     */
    public var packageSupplier: String?

    /**
     3.6 Package Originator
     3.6.1 Purpose: If the package identified in the SPDX file originated from a different person
     or organization than identified as Package Supplier (see section 3.5 above), this field
     identifies from where or whom the package originally came. In some cases a package may
     be created and originally distributed by a different third party than the Package Supplier of
     the package. For example, the SPDX file identifies the package glibc and Red Hat as the
     Package Supplier, but the Free Software Foundation is the Package Originator.
     Use NOASSERTION if:
     (i) the SPDX file creator has attempted to but cannot reach a reasonable objective
     determination;
     (ii) the SPDX file creator has made no attempt to determine this field; or
     (iii) the SPDX file creator has intentionally provided no information (no meaning should be
     implied by doing so).
     3.6.2 Intent: Assist with understanding the point of origin of the code in the package. This
     field is vital for understanding who originally distributed a package and should help in
     addressing any ambiguity or concerns that might arise with the information in the SPDX
     file or the contents of the Package it documents.
     3.6.3 Cardinality: Optional, one.
     3.6.4 Data Format: Single line of text with the following keywords | NOASSERTION
     • Person: person name and optional (<email>)
     • Organization: organization name and optional (<email>)
     3.6.5 Tag: PackageOriginator:
     Example:
     PackageOriginator: Organization: ExampleCodeInspect (contact@example.com)
     3.6.6 RDF: property spdx:originator in class spdx:Package
     <Package rdf:about="...">
      <originator>Organization: ExampleCodeInspect
     (contact@example.com)</originator>
     </Package>
     */
    public var packageOriginator: String?

    /**
     3.7 Package Download Location
     3.7.1 Purpose: This section identifies the download Universal Resource Locator (URL), or a
     specific location within a version control system (VCS) for the package at the time that the
     SPDX file was created.
     Use:
     • NONE if there is no download location whatsoever.
     • NOASSERTION if:
     (i) the SPDX file creator has attempted to but cannot reach a reasonable objective
     determination;
     (ii) the SPDX file creator has made no attempt to determine this field; or
     (iii) the SPDX file creator has intentionally provided no information (no meaning
     should be implied by doing so).
     3.7.2 Intent: Where and how to download the exact package being referenced is critical
     verification and tracking data.
     3.7.3 Cardinality: Mandatory, one.
     3.7.4 Data Format: uniform resource locator | VCS location | NONE | NOASSERTION
     For version-controlled files, the VCS location syntax is similar to a URL and has the:
     <vcs_tool>+<transport>://<host_name>[/<path_to_repository>][@<revision_tag_or
     _branch>][#<sub_path>]
     This VCS location compact notation (inspired and mostly adopted from pip as of 2015-02-
     20) supports referencing locations in version control systems such as Git, Mercurial,
     Subversion and Bazaar, and specifies the type of VCS tool using url prefixes: git+, hg+, bzr+,
     svn+ and specific transport schemes such as SSH or HTTPS.
     Specifying sub-paths, branch names, a commit hash, a revision or a tag name is
     recommended, and supported using the @ delimiter for commits and the # delimiter for
     sub-paths.
     Using user names and password in the <host_name> is not supported and should be
     considered as an error. User access control to URLs or VCS repositories must be handled
     outside of an SPDX document.

     In VCS location compact notations, the trailing slashes in <host_name>,
     <path_to_repository> are not significant. Leading and trailing slashes in <sub_path> are
     not significant.
     3.7.5 Tag: PackageDownloadLocation:
     Examples if ambiguous:
     PackageDownloadLocation: NOASSERTION
     PackageDownloadLocation: NONE
     Example for a plain URL:
     PackageDownloadLocation: http://ftp.gnu.org/gnu/glibc/glibc-ports-2.15.tar.gz
     Example for Git:
     SPDX supported schemes are: git, git+git, git+https, git+http, and git+ssh. git and
     git+git are equivalent.
     Here are the supported forms:
     PackageDownloadLocation: git://git.myproject.org/MyProject
     PackageDownloadLocation: git+https://git.myproject.org/MyProject.git
     PackageDownloadLocation: git+http://git.myproject.org/MyProject
     PackageDownloadLocation: git+ssh://git.myproject.org/MyProject.git
     PackageDownloadLocation: git+git://git.myproject.org/MyProject
     PackageDownloadLocation: git+git@git.myproject.org:MyProject
     To specify a sub-path to a file or directory inside a repository use the # delimiter:
     PackageDownloadLocation: git://git.myproject.org/MyProject#src/somefile.c
     PackageDownloadLocation:
     git+https://git.myproject.org/MyProject#src/Class.java
     To specify branch names, a commit hash or a tag name, use the @ delimiter:
     PackageDownloadLocation: git://git.myproject.org/MyProject.git@master
     PackageDownloadLocation: git+https://git.myproject.org/MyProject.git@v1.0
     PackageDownloadLocation:
     git://git.myproject.org/MyProject.git@da39a3ee5e6b4b0d3255bfef95601890afd8070
     9
     Sub-paths and branch names or commit hash can be combined too:

     PackageDownloadLocation:
     git+https://git.myproject.org/MyProject.git@master#/src/MyClass.cpp
     PackageDownloadLocation:
     git+https://git.myproject.org/MyProject@da39a3ee5e6b4b0d3255bfef95601890afd80
     709#lib/variable.rb
     Example for Mercurial:
     SPDX supported schemes are: hg+http, hg+https, hg+static-http, and hg+ssh.
     The supported forms are:
     PackageDownloadLocation: hg+http://hg.myproject.org/MyProject
     PackageDownloadLocation: hg+https://hg.myproject.org/MyProject
     PackageDownloadLocation: hg+ssh://hg.myproject.org/MyProject
     To specify a sub-path to a file or directory inside a repository use the # delimiter:
     PackageDownloadLocation: hg+https://hg.myproject.org/MyProject#src/somefile.c
     PackageDownloadLocation: hg+https://hg.myproject.org/MyProject#src/Class.java
     To pass branch names, a commit hash, a tag name or a local branch name use the @
     delimiter:
     PackageDownloadLocation: hg+https://hg.myproject.org/MyProject@da39a3ee5e6b
     PackageDownloadLocation: hg+https://hg.myproject.org/MyProject@2019
     PackageDownloadLocation: hg+https://hg.myproject.org/MyProject@v1.0
     PackageDownloadLocation:
     hg+https://hg.myproject.org/MyProject@special_feature
     Sub-paths and branch names or commit hash can be combined too:
     PackageDownloadLocation:
     hg+https://hg.myproject.org/MyProject@master#/src/MyClass.cpp
     PackageDownloadLocation:
     hg+https://hg.myproject.org/MyProject@da39a3ee5e6b#lib/variable.rb
     Example for Subversion:
     SPDX supported schemes are: svn, svn+svn, svn+http, svn+https, svn+ssh. svn and
     svn+svn are equivalent.
     The supported forms are:
     PackageDownloadLocation: svn://svn.myproject.org/svn/MyProject

     PackageDownloadLocation: svn+svn://svn.myproject.org/svn/MyProject
     PackageDownloadLocation: svn+http://svn.myproject.org/svn/MyProject/trunk
     PackageDownloadLocation: svn+https://svn.myproject.org/svn/MyProject/trunk
     To specify a sub-path to a file or directory inside a repository use the # delimiter:
     PackageDownloadLocation:
     svn+https://svn.myproject.org/MyProject#src/somefile.c
     PackageDownloadLocation:
     svn+https://svn.myproject.org/MyProject#src/Class.java
     This support is less important for SVN since the URL path can also contain sub-paths; this
     two forms are equivalent:
     PackageDownloadLocation:
     svn+https://svn.myproject.org/MyProject/trunk#src/somefile.c
     PackageDownloadLocation:
     svn+https://svn.myproject.org/MyProject/trunk/src/somefile.c
     You can specify a revision using the @ delimiter:
     PackageDownloadLocation:
     svn+https://svn.myproject.org/svn/MyProject/trunk@2019
     Sub-paths and revisions can be combined too:
     PackageDownloadLocation:
     svn+https://svn.myproject.org/MyProject@123#/src/MyClass.cpp
     PackageDownloadLocation:
     svn+https://svn.myproject.org/MyProject/trunk@1234#lib/variable/variable.rb
     Example for Bazaar:
     SPDX supported schemes are: bzr+http, bzr+https, bzr+ssh, bzr+sftp, bzr+ftp, and
     bzr+lp.
     The supported forms are:
     PackageDownloadLocation: bzr+https://bzr.myproject.org/MyProject/trunk
     PackageDownloadLocation: bzr+http://bzr.myproject.org/MyProject/trunk
     PackageDownloadLocation: bzr+sftp://myproject.org/MyProject/trunk
     PackageDownloadLocation: bzr+ssh://myproject.org/MyProject/trunk
     PackageDownloadLocation: bzr+ftp://myproject.org/MyProject/trunk
     PackageDownloadLocation: bzr+lp:MyProject

     To specify a sub-path to a file or directory inside a repository use the # delimiter:
     PackageDownloadLocation:
     bzr+https://bzr.myproject.org/MyProject/trunk#src/somefile.c
     PackageDownloadLocation:
     bzr+https://bzr.myproject.org/MyProject/trunk#src/Class.java
     You can specify a revision or tag using the @ delimiter:
     PackageDownloadLocation: bzr+https://bzr.myproject.org/MyProject/trunk@2019
     PackageDownloadLocation: bzr+http://bzr.myproject.org/MyProject/trunk@v1.0
     Sub-paths and revisions can be combined too:
     PackageDownloadLocation:
     bzr+https://bzr.myproject.org/MyProject/trunk@2019#src/somefile.c
     3.7.6 RDF: property spdx:downloadLocation in class spdx:Package
     Example:
     <Package rdf:about="...">
      <downloadLocation>http://ftp.gnu.org/gnu/glibc/glibc-ports2.15.tar.gz</downloadLocation>
     </Package>
     <Package rdf:about="...">
      <downloadLocation>
      git+https://git.myproject.org/MyProject.git@v10.0#src/lib.c
      </downloadLocation>
     </Package>
     <Package rdf:about="...">
      <downloadLocation rdf:resource="spdx:noassertion"/>
     </Package>
     <Package rdf:about="...">
      <downloadLocation rdf:resource="spdx:none"/>
     </Package>
     */
    public var packageDownloadLocation: String

    /**
     3.8 Files Analyzed
     3.8.1 Purpose: Indicates whether the file content of this package has been available for or
     subjected to analysis when creating the SPDX document. If false, indicates packages that
     represent metadata or URI references to a project, product, artifact, distribution or a
     component. If false, the package must not contain any files.
     3.8.2 Intent: A package can refer to a project, product, artifact, distribution or a component
     that is external to the SPDX document.
     Some examples:
     1. A bundle of external products: Package A can be metadata about Packages and their
     dependencies. It may also be a loosely organized manifest of references to Packages
     involved in a product or project. Build or execution may transitively discover more
     Packages and dependencies. All of these referenced Packages can have their own SPDX
     Documents. In this case, Package A may be defined with its File Analyzed attribute set
     to false. Package A includes External Document References to SPDX documents
     containing Packages referenced in all the available relationships. The Relationships
     section then relates the SPDX documents and contained SPDX elements with
     appropriate semantics per the dependencies in the scope of Package A.
     2. Package relation to external product: Package A can have a STATIC_LINK
     relationship to Package B, but the binary representation of Package B is furnished by
     the build process and thus not contained in the file list of Package A. In this case,
     Package B needs to be defined with its Files Analyzed attribute set to false and all the
     other attributes subject to the subsequently defined constraints. Then, the relationship
     between Package A and Package B can be documented as described in Section 7.
     3. File derived from external product: Package A contains multiple files derived from
     an outside project. Rather than use the artifactOf* attributes (Sections 4.9-4.11) to
     describe the relation of these files to their project, the outside project can be
     represented by another package, Package B, whose FilesAnalyzed attribute is set to
     false. Each of the binary files can then have a relationship to package B (Section 6).
     This allows the outside project to be represented by a single SPDX identifier (the
     identifier of Package B). It also allows the relationship(s) between the outside project
     and each of the files be represented in much more detail.
     3.8.3 Cardinality: Optional, one. If omitted, the default value of true is assumed.
     3.8.4 Data Format: Boolean
     3.8.5 Tag: FilesAnalyzed
     Example:
     FilesAnalyzed: false
     3.8.6 RDF: property spdx:filesAnalyzed in class spdx:Package
     Example:
     <Package rdf:about="...">
      ...
      <filesAnalyzed>false</filesAnalyzed>
      ...
     </Package>
     */
    public var filesAnalyzed: Bool

    /**
     3.9 Package Verification Code
     3.9.1 Purpose: This field provides an independently reproducible mechanism identifying
     specific contents of a package based on the actual files (except the SPDX file itself, if it is
     included in the package) that make up each package and that correlates to the data in this
     SPDX file. This identifier enables a recipient to determine if any file in the original package
     (that the analysis was done on) has been changed and permits inclusion of an SPDX file as
     part of a package.
     3.9.2 Intent: Provide a unique identifier based on the files inside each package, eliminating
     confusion over which version or modification of a specific package the SPDX file refers to.
     This field also permits embedding the SPDX file within the package without altering the
     identifier.
     3.9.3 Cardinality: Mandatory, one if FilesAnalyzed is true or omitted, zero (must be
     omitted) if FilesAnalyzed is false.
     3.9.4 Algorithm:
     verificationcode = 0
     filelist = templist = ""
     for all files in the package {
      if file is an "excludes" file, skip it /* exclude SPDX analysis file(s)
     */
      append templist with "SHA1(file)/n"
      }
     sort templist in ascending order by SHA1 value
     filelist = templist with "/n"s removed. /* ordered sequence of SHA1 values
     with no separators */
     verificationcode = SHA1(filelist)
     Where SHA1(file) applies a SHA1 algorithm on the contents of file and returns the result in
     lowercase hexadecimal digits.
     Required sort order: ‘0’,‘1’,‘2’,‘3’,‘4’,‘5’,‘6’,‘7’,‘8’,‘9’,‘a’,‘b’,‘c’,‘d’,‘e’,‘f’ (ASCII order)
     3.9.5 Data Format: single line of text with 160 bit binary represented as 40 lowercase
     hexadecimal digits
     3.9.6 Tag: PackageVerificationCode: (and optionally (excludes: FileName))
     FileName is specified in section 4.1.
     Example:
     PackageVerificationCode: d6a770ba38583ed4bb4525bd96e50461655d2758 (excludes:
     ./package.spdx)

     3.9.7 RDF: spdx:packageVerificationCodeValue,
     spdx:packageVerificationCodeExcludedFile in class spdx:PackageVerificationCode in
     class spdx:Package
     Example:
     <Package rdf:about="...">
      <packageVerificationCode>
      <PackageVerificationCode>
      <packageVerificationCodeValue>
      d6a770ba38583ed4bb4525bd96e50461655d2758
      </packageVerificationCodeValue>
      <packageVerificationCodeExcludedFile>
      ./package.spdx
      </packageVerificationCodeExcludedFile>
      </PackageVerificationCode>
      </packageVerificationCode>
     </Package>
     */
    public var packageVerificationCode: (String, excludes: String?)?
}
