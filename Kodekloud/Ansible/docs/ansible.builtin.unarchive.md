# ansible.builtin.unarchive


<h1>ansible.builtin.unarchive module – Unpacks an archive after (optionally) copying it from the local machine<a class="headerlink" href="#ansible-builtin-unarchive-module-unpacks-an-archive-after-optionally-copying-it-from-the-local-machine" title="Permalink to this heading"></a></h1>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>This module    is part of <code class="docutils literal notranslate"><span class="pre">ansible-core</span></code> and included in all Ansible
installations. In most cases, you can use the short
module name
<code class="code docutils literal notranslate"><span class="pre">unarchive</span></code> even without specifying the <a class="reference internal" href="../../../collections_guide/collections_using_playbooks.html#collections-keyword"><span class="std std-ref">collections keyword</span></a>.
However, we recommend you use the <a class="reference internal" href="../../../reference_appendices/glossary.html#term-Fully-Qualified-Collection-Name-FQCN"><span class="xref std std-term">Fully Qualified Collection Name (FQCN)</span></a> <code class="code docutils literal notranslate"><span class="pre">ansible.builtin.unarchive</span></code> for easy linking to the
module    documentation and to avoid conflicting with other collections that may have
the same module name.</p>
</div>
<nav class="contents local" id="contents">
<ul class="simple">
<li><p><a class="reference internal" href="#synopsis" id="id1">Synopsis</a></p></li>
<li><p><a class="reference internal" href="#parameters" id="id2">Parameters</a></p></li>
<li><p><a class="reference internal" href="#attributes" id="id3">Attributes</a></p></li>
<li><p><a class="reference internal" href="#notes" id="id4">Notes</a></p></li>
<li><p><a class="reference internal" href="#see-also" id="id5">See Also</a></p></li>
<li><p><a class="reference internal" href="#examples" id="id6">Examples</a></p></li>
<li><p><a class="reference internal" href="#return-values" id="id7">Return Values</a></p></li>
</ul>
</nav>
<section id="synopsis">
<h2><a class="toc-backref" href="#id1" role="doc-backlink">Synopsis</a><a class="headerlink" href="#synopsis" title="Permalink to this heading"></a></h2>
<ul class="simple">
<li><p>The <a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module"><span class="std std-ref">ansible.builtin.unarchive</span></a> module unpacks an archive. It will not unpack a compressed file that does not contain an archive.</p></li>
<li><p>By default, it will copy the source file from the local system to the target before unpacking.</p></li>
<li><p>Set <code class="ansible-option-value docutils literal notranslate"><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-remote-src"><span class="std std-ref"><span class="pre">remote_src=yes</span></span></a></code> to unpack an archive which already exists on the target.</p></li>
<li><p>If checksum validation is desired, use <a class="reference internal" href="get_url_module.html#ansible-collections-ansible-builtin-get-url-module"><span class="std std-ref">ansible.builtin.get_url</span></a> or <a class="reference internal" href="uri_module.html#ansible-collections-ansible-builtin-uri-module"><span class="std std-ref">ansible.builtin.uri</span></a> instead to fetch the file and set <code class="ansible-option-value docutils literal notranslate"><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-remote-src"><span class="std std-ref"><span class="pre">remote_src=yes</span></span></a></code>.</p></li>
<li><p>For Windows targets, use the <a class="reference internal" href="../../community/windows/win_unzip_module.html#ansible-collections-community-windows-win-unzip-module"><span class="std std-ref">community.windows.win_unzip</span></a> module instead.</p></li>
</ul>
<div class="admonition note">
<p class="admonition-title">Note</p>
<p>This module has a corresponding <a class="reference internal" href="../../../plugins/action.html#action-plugins"><span class="std std-ref">action plugin</span></a>.</p>
</div>
</section>
<section id="parameters">
<h2><a class="toc-backref" href="#id2" role="doc-backlink">Parameters</a><a class="headerlink" href="#parameters" title="Permalink to this heading"></a></h2>
<div class="wy-table-responsive"><table class="longtable ansible-option-table docutils align-default" style="width: 100%">
<thead>
<tr class="row-odd"><th class="head"><p>Parameter</p></th>
<th class="head"><p>Comments</p></th>
</tr>
</thead>
<tbody>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-attributes"></div>
<div class="ansibleOptionAnchor" id="parameter-attr"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-attributes"><span id="ansible-collections-ansible-builtin-unarchive-module-parameter-attr"></span><strong>attributes</strong></p>
<a class="ansibleOptionLink" href="#parameter-attributes" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-aliases">aliases: attr</span></p>
<p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The attributes the resulting filesystem object should have.</p>
<p>To get supported flags look at the man page for <em>chattr</em> on the target system.</p>
<p>This string should contain the attributes in the same order as the one displayed by <em>lsattr</em>.</p>
<p>The <code class="docutils literal notranslate"><span class="pre">=</span></code> operator is assumed as default, otherwise <code class="docutils literal notranslate"><span class="pre">+</span></code> or <code class="docutils literal notranslate"><span class="pre">-</span></code> operators need to be included in the string.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-copy"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-copy"><strong>copy</strong></p>
<a class="ansibleOptionLink" href="#parameter-copy" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">boolean</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>If true, the file is copied from local controller to the managed (remote) node, otherwise, the plugin will look for src archive on the managed machine.</p>
<p>This option has been deprecated in favor of <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-remote-src"><span class="std std-ref"><span class="pre">remote_src</span></span></a></strong></code>.</p>
<p>This option is mutually exclusive with <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-remote-src"><span class="std std-ref"><span class="pre">remote_src</span></span></a></strong></code>.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">false</span></code></p></li>
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">true</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
</ul>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-creates"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-creates"><strong>creates</strong></p>
<a class="ansibleOptionLink" href="#parameter-creates" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">path</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>If the specified absolute path (file or directory) already exists, this step will <strong>not</strong> be run.</p>
<p>The specified absolute path (file or directory) must be below the base path given with <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-dest"><span class="std std-ref"><span class="pre">dest</span></span></a></strong></code>.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-decrypt"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-decrypt"><strong>decrypt</strong></p>
<a class="ansibleOptionLink" href="#parameter-decrypt" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">boolean</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>This option controls the autodecryption of source files using vault.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">false</span></code></p></li>
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">true</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
</ul>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-dest"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-dest"><strong>dest</strong></p>
<a class="ansibleOptionLink" href="#parameter-dest" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">path</span> / <span class="ansible-option-required">required</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Remote absolute path where the archive should be unpacked.</p>
<p>The given path must exist. Base directory is not created by this module.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-exclude"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-exclude"><strong>exclude</strong></p>
<a class="ansibleOptionLink" href="#parameter-exclude" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">list</span> / <span class="ansible-option-elements">elements=string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>List the directory and file entries that you would like to exclude from the unarchive action.</p>
<p>Mutually exclusive with <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-include"><span class="std std-ref"><span class="pre">include</span></span></a></strong></code>.</p>
<p class="ansible-option-line"><strong class="ansible-option-default-bold">Default:</strong> <code class="ansible-option-default docutils literal notranslate"><span class="pre">[]</span></code></p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-extra_opts"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-extra-opts"><strong>extra_opts</strong></p>
<a class="ansibleOptionLink" href="#parameter-extra_opts" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">list</span> / <span class="ansible-option-elements">elements=string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Specify additional options by passing in an array.</p>
<p>Each space-separated command-line option should be a new element of the array. See examples.</p>
<p>Command-line options with multiple elements must use multiple lines in the array, one for each element.</p>
<p class="ansible-option-line"><strong class="ansible-option-default-bold">Default:</strong> <code class="ansible-option-default docutils literal notranslate"><span class="pre">[]</span></code></p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-group"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-group"><strong>group</strong></p>
<a class="ansibleOptionLink" href="#parameter-group" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Name of the group that should own the filesystem object, as would be fed to <em>chown</em>.</p>
<p>When left unspecified, it uses the current group of the current user unless you are root, in which case it can preserve the previous ownership.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-include"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-include"><strong>include</strong></p>
<a class="ansibleOptionLink" href="#parameter-include" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">list</span> / <span class="ansible-option-elements">elements=string</span></p>
<p><em class="ansible-option-versionadded">added in ansible-core 2.11</em></p>
</div></td>
<td><div class="ansible-option-cell"><p>List of directory and file entries that you would like to extract from the archive. If <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-include"><span class="std std-ref"><span class="pre">include</span></span></a></strong></code> is not empty, only files listed here will be extracted.</p>
<p>Mutually exclusive with <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-exclude"><span class="std std-ref"><span class="pre">exclude</span></span></a></strong></code>.</p>
<p class="ansible-option-line"><strong class="ansible-option-default-bold">Default:</strong> <code class="ansible-option-default docutils literal notranslate"><span class="pre">[]</span></code></p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-io_buffer_size"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-io-buffer-size"><strong>io_buffer_size</strong></p>
<a class="ansibleOptionLink" href="#parameter-io_buffer_size" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">integer</span></p>
<p><em class="ansible-option-versionadded">added in ansible-core 2.12</em></p>
</div></td>
<td><div class="ansible-option-cell"><p>Size of the volatile memory buffer that is used for extracting files from the archive in bytes.</p>
<p class="ansible-option-line"><strong class="ansible-option-default-bold">Default:</strong> <code class="ansible-option-default docutils literal notranslate"><span class="pre">65536</span></code></p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-keep_newer"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-keep-newer"><strong>keep_newer</strong></p>
<a class="ansibleOptionLink" href="#parameter-keep_newer" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">boolean</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Do not replace existing files that are newer than files from the archive.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">false</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">true</span></code></p></li>
</ul>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-list_files"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-list-files"><strong>list_files</strong></p>
<a class="ansibleOptionLink" href="#parameter-list_files" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">boolean</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>If set to True, return the list of files that are contained in the tarball.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">false</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">true</span></code></p></li>
</ul>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-mode"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-mode"><strong>mode</strong></p>
<a class="ansibleOptionLink" href="#parameter-mode" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">any</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The permissions the resulting filesystem object should have.</p>
<p>For those used to <em>/usr/bin/chmod</em> remember that modes are actually octal numbers. You must give Ansible enough information to parse them correctly. For consistent results, quote octal numbers (for example, <code class="ansible-value docutils literal notranslate"><span class="pre">'644'</span></code> or <code class="ansible-value docutils literal notranslate"><span class="pre">'1777'</span></code>) so Ansible receives a string and can do its own conversion from string into number. Adding a leading zero (for example, <code class="ansible-value docutils literal notranslate"><span class="pre">0755</span></code>) works sometimes, but can fail in loops and some other circumstances.</p>
<p>Giving Ansible a number without following either of these rules will end up with a decimal number which will have unexpected results.</p>
<p>As of Ansible 1.8, the mode may be specified as a symbolic mode (for example, <code class="ansible-value docutils literal notranslate"><span class="pre">u+rwx</span></code> or <code class="ansible-value docutils literal notranslate"><span class="pre">u=rw,g=r,o=r</span></code>).</p>
<p>If <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-mode"><span class="std std-ref"><span class="pre">mode</span></span></a></strong></code> is not specified and the destination filesystem object <strong>does not</strong> exist, the default <code class="docutils literal notranslate"><span class="pre">umask</span></code> on the system will be used when setting the mode for the newly created filesystem object.</p>
<p>If <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-mode"><span class="std std-ref"><span class="pre">mode</span></span></a></strong></code> is not specified and the destination filesystem object <strong>does</strong> exist, the mode of the existing filesystem object will be used.</p>
<p>Specifying <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-mode"><span class="std std-ref"><span class="pre">mode</span></span></a></strong></code> is the best way to ensure filesystem objects are created with the correct permissions. See CVE-2020-1736 for further details.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-owner"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-owner"><strong>owner</strong></p>
<a class="ansibleOptionLink" href="#parameter-owner" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Name of the user that should own the filesystem object, as would be fed to <em>chown</em>.</p>
<p>When left unspecified, it uses the current user unless you are root, in which case it can preserve the previous ownership.</p>
<p>Specifying a numeric username will be assumed to be a user ID and not a username. Avoid numeric usernames to avoid this confusion.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-remote_src"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-remote-src"><strong>remote_src</strong></p>
<a class="ansibleOptionLink" href="#parameter-remote_src" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">boolean</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Set to <code class="ansible-value docutils literal notranslate"><span class="pre">true</span></code> to indicate the archived file is already on the remote system and not local to the Ansible controller.</p>
<p>This option is mutually exclusive with <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-copy"><span class="std std-ref"><span class="pre">copy</span></span></a></strong></code>.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">false</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">true</span></code></p></li>
</ul>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-selevel"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-selevel"><strong>selevel</strong></p>
<a class="ansibleOptionLink" href="#parameter-selevel" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The level part of the SELinux filesystem object context.</p>
<p>This is the MLS/MCS attribute, sometimes known as the <code class="docutils literal notranslate"><span class="pre">range</span></code>.</p>
<p>When set to <code class="ansible-value docutils literal notranslate"><span class="pre">_default</span></code>, it will use the <code class="docutils literal notranslate"><span class="pre">level</span></code> portion of the policy if available.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-serole"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-serole"><strong>serole</strong></p>
<a class="ansibleOptionLink" href="#parameter-serole" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The role part of the SELinux filesystem object context.</p>
<p>When set to <code class="ansible-value docutils literal notranslate"><span class="pre">_default</span></code>, it will use the <code class="docutils literal notranslate"><span class="pre">role</span></code> portion of the policy if available.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-setype"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-setype"><strong>setype</strong></p>
<a class="ansibleOptionLink" href="#parameter-setype" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The type part of the SELinux filesystem object context.</p>
<p>When set to <code class="ansible-value docutils literal notranslate"><span class="pre">_default</span></code>, it will use the <code class="docutils literal notranslate"><span class="pre">type</span></code> portion of the policy if available.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-seuser"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-seuser"><strong>seuser</strong></p>
<a class="ansibleOptionLink" href="#parameter-seuser" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The user part of the SELinux filesystem object context.</p>
<p>By default it uses the <code class="ansible-value docutils literal notranslate"><span class="pre">system</span></code> policy, where applicable.</p>
<p>When set to <code class="ansible-value docutils literal notranslate"><span class="pre">_default</span></code>, it will use the <code class="docutils literal notranslate"><span class="pre">user</span></code> portion of the policy if available.</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-src"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-src"><strong>src</strong></p>
<a class="ansibleOptionLink" href="#parameter-src" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">path</span> / <span class="ansible-option-required">required</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>If <code class="ansible-option-value docutils literal notranslate"><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-remote-src"><span class="std std-ref"><span class="pre">remote_src=no</span></span></a></code> (default), local path to archive file to copy to the target server; can be absolute or relative. If <code class="ansible-option-value docutils literal notranslate"><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-remote-src"><span class="std std-ref"><span class="pre">remote_src=yes</span></span></a></code>, path on the target server to existing archive file to unpack.</p>
<p>If <code class="ansible-option-value docutils literal notranslate"><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-remote-src"><span class="std std-ref"><span class="pre">remote_src=yes</span></span></a></code> and <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-src"><span class="std std-ref"><span class="pre">src</span></span></a></strong></code> contains <code class="ansible-value docutils literal notranslate"><span class="pre">://</span></code>, the remote machine will download the file from the URL first. (version_added 2.0). This is only for simple cases, for full download support use the <a class="reference internal" href="get_url_module.html#ansible-collections-ansible-builtin-get-url-module"><span class="std std-ref">ansible.builtin.get_url</span></a> module.</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-unsafe_writes"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-unsafe-writes"><strong>unsafe_writes</strong></p>
<a class="ansibleOptionLink" href="#parameter-unsafe_writes" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">boolean</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Influence when to use atomic operation to prevent data corruption or inconsistent reads from the target filesystem object.</p>
<p>By default this module uses atomic operations to prevent data corruption or inconsistent reads from the target filesystem objects, but sometimes systems are configured or just broken in ways that prevent this. One example is docker mounted filesystem objects, which cannot be updated atomically from inside the container and can only be written in an unsafe manner.</p>
<p>This option allows Ansible to fall back to unsafe methods of updating filesystem objects when atomic operations fail (however, it doesn’t force Ansible to perform unsafe writes).</p>
<p>IMPORTANT! Unsafe writes are subject to race conditions and can lead to data corruption.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">false</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">true</span></code></p></li>
</ul>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="parameter-validate_certs"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-parameter-validate-certs"><strong>validate_certs</strong></p>
<a class="ansibleOptionLink" href="#parameter-validate_certs" title="Permalink to this option"></a><p class="ansible-option-type-line"><span class="ansible-option-type">boolean</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>This only applies if using a https URL as the source of the file.</p>
<p>This should only set to <code class="ansible-value docutils literal notranslate"><span class="pre">false</span></code> used on personally controlled sites using self-signed certificate.</p>
<p>Prior to 2.2 the code worked as if this was set to <code class="ansible-value docutils literal notranslate"><span class="pre">true</span></code>.</p>
<p class="ansible-option-line"><strong class="ansible-option-choices">Choices:</strong></p>
<ul class="simple">
<li><p><code class="ansible-option-choices-entry docutils literal notranslate"><span class="pre">false</span></code></p></li>
<li><p><code class="ansible-option-default-bold docutils literal notranslate"><strong><span class="pre">true</span></strong></code> <span class="ansible-option-choices-default-mark">← (default)</span></p></li>
</ul>
</div></td>
</tr>
</tbody>
</table></div>
</section>
<section id="attributes">
<h2><a class="toc-backref" href="#id3" role="doc-backlink">Attributes</a><a class="headerlink" href="#attributes" title="Permalink to this heading"></a></h2>
<div class="wy-table-responsive"><table class="longtable ansible-option-table docutils align-default" style="width: 100%">
<thead>
<tr class="row-odd"><th class="head"><p>Attribute</p></th>
<th class="head"><p>Support</p></th>
<th class="head"><p>Description</p></th>
</tr>
</thead>
<tbody>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-action"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-attribute-action"><strong>action</strong></p>
<a class="ansibleOptionLink" href="#attribute-action" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-label">Support: </strong><strong class="ansible-attribute-support-full">full</strong></p>
</div></td>
<td><div class="ansible-option-cell"><p>Indicates this has a corresponding action plugin so some parts of the options can be executed on the controller</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-async"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-attribute-async"><strong>async</strong></p>
<a class="ansibleOptionLink" href="#attribute-async" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-label">Support: </strong><strong class="ansible-attribute-support-none">none</strong></p>
</div></td>
<td><div class="ansible-option-cell"><p>Supports being used with the <code class="docutils literal notranslate"><span class="pre">async</span></code> keyword</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-bypass_host_loop"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-attribute-bypass-host-loop"><strong>bypass_host_loop</strong></p>
<a class="ansibleOptionLink" href="#attribute-bypass_host_loop" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-label">Support: </strong><strong class="ansible-attribute-support-none">none</strong></p>
</div></td>
<td><div class="ansible-option-cell"><p>Forces a ‘global’ task that does not execute per host, this bypasses per host templating and serial, throttle and other loop considerations</p>
<p>Conditionals will work as if <code class="docutils literal notranslate"><span class="pre">run_once</span></code> is being used, variables used will be from the first available host</p>
<p>This action will not work normally outside of lockstep strategies</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-check_mode"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-attribute-check-mode"><strong>check_mode</strong></p>
<a class="ansibleOptionLink" href="#attribute-check_mode" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-label">Support: </strong><strong class="ansible-attribute-support-partial">partial</strong></p>
<p>Not supported for gzipped tar files.</p>
</div></td>
<td><div class="ansible-option-cell"><p>Can run in check_mode and return changed status prediction without modifying target</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-diff_mode"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-attribute-diff-mode"><strong>diff_mode</strong></p>
<a class="ansibleOptionLink" href="#attribute-diff_mode" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-label">Support: </strong><strong class="ansible-attribute-support-partial">partial</strong></p>
<p>Uses gtar’s <code class="docutils literal notranslate"><span class="pre">--diff</span></code> arg to calculate if changed or not. If this <code class="docutils literal notranslate"><span class="pre">arg</span></code> is not supported, it will always unpack the archive.</p>
</div></td>
<td><div class="ansible-option-cell"><p>Will return details on what has changed (or possibly needs changing in check_mode), when in diff mode</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-platform"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-attribute-platform"><strong>platform</strong></p>
<a class="ansibleOptionLink" href="#attribute-platform" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-property">Platform:</strong>&nbsp;<strong class="ansible-attribute-support-full">posix</strong></p>
</div></td>
<td><div class="ansible-option-cell"><p>Target OS/families that can be operated against</p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-safe_file_operations"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-attribute-safe-file-operations"><strong>safe_file_operations</strong></p>
<a class="ansibleOptionLink" href="#attribute-safe_file_operations" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-label">Support: </strong><strong class="ansible-attribute-support-none">none</strong></p>
</div></td>
<td><div class="ansible-option-cell"><p>Uses Ansible’s strict file operation functions to ensure proper permissions and avoid data corruption</p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="attribute-vault"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-attribute-vault"><strong>vault</strong></p>
<a class="ansibleOptionLink" href="#attribute-vault" title="Permalink to this attribute"></a></div></td>
<td><div class="ansible-option-cell"><p><strong class="ansible-attribute-support-label">Support: </strong><strong class="ansible-attribute-support-full">full</strong></p>
</div></td>
<td><div class="ansible-option-cell"><p>Can automatically decrypt Ansible vaulted files</p>
</div></td>
</tr>
</tbody>
</table></div>
</section>
<section id="notes">
<h2><a class="toc-backref" href="#id4" role="doc-backlink">Notes</a><a class="headerlink" href="#notes" title="Permalink to this heading"></a></h2>
<div class="admonition note">
<p class="admonition-title">Note</p>
<ul class="simple">
<li><p>Requires <code class="docutils literal notranslate"><span class="pre">zipinfo</span></code> and <code class="docutils literal notranslate"><span class="pre">gtar</span></code>/<code class="docutils literal notranslate"><span class="pre">unzip</span></code> command on target host.</p></li>
<li><p>Requires <code class="docutils literal notranslate"><span class="pre">zstd</span></code> command on target host to expand <em>.tar.zst</em> files.</p></li>
<li><p>Can handle <em>.zip</em> files using <code class="docutils literal notranslate"><span class="pre">unzip</span></code> as well as <em>.tar</em>, <em>.tar.gz</em>, <em>.tar.bz2</em>, <em>.tar.xz</em>, and <em>.tar.zst</em> files using <code class="docutils literal notranslate"><span class="pre">gtar</span></code>.</p></li>
<li><p>Does not handle <em>.gz</em> files, <em>.bz2</em> files, <em>.xz</em>, or <em>.zst</em> files that do not contain a <em>.tar</em> archive.</p></li>
<li><p>Existing files/directories in the destination which are not in the archive are not touched. This is the same behavior as a normal archive extraction.</p></li>
<li><p>Existing files/directories in the destination which are not in the archive are ignored for purposes of deciding if the archive should be unpacked or not.</p></li>
</ul>
</div>
</section>
<section id="see-also">
<h2><a class="toc-backref" href="#id5" role="doc-backlink">See Also</a><a class="headerlink" href="#see-also" title="Permalink to this heading"></a></h2>
<div class="admonition seealso">
<p class="admonition-title">See also</p>
<dl class="simple">
<dt><a class="reference internal" href="../../community/general/archive_module.html#ansible-collections-community-general-archive-module"><span class="std std-ref">community.general.archive</span></a></dt><dd><p>Creates a compressed archive of one or more files or trees.</p>
</dd>
<dt><a class="reference internal" href="../../community/general/iso_extract_module.html#ansible-collections-community-general-iso-extract-module"><span class="std std-ref">community.general.iso_extract</span></a></dt><dd><p>Extract files from an ISO image.</p>
</dd>
<dt><a class="reference internal" href="../../community/windows/win_unzip_module.html#ansible-collections-community-windows-win-unzip-module"><span class="std std-ref">community.windows.win_unzip</span></a></dt><dd><p>Unzips compressed files and archives on the Windows node.</p>
</dd>
</dl>
</div>
</section>
<section id="examples">
<h2><a class="toc-backref" href="#id6" role="doc-backlink">Examples</a><a class="headerlink" href="#examples" title="Permalink to this heading"></a></h2>
<div class="highlight-yaml+jinja notranslate"><div class="highlight"><pre id="codecell0"><span></span><span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Extract foo.tgz into /var/lib/foo</span>
<span class="w">  </span><span class="nt">ansible.builtin.unarchive</span><span class="p">:</span>
<span class="w">    </span><span class="nt">src</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">foo.tgz</span>
<span class="w">    </span><span class="nt">dest</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/var/lib/foo</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Unarchive a file that is already on the remote machine</span>
<span class="w">  </span><span class="nt">ansible.builtin.unarchive</span><span class="p">:</span>
<span class="w">    </span><span class="nt">src</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/tmp/foo.zip</span>
<span class="w">    </span><span class="nt">dest</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/usr/local/bin</span>
<span class="w">    </span><span class="nt">remote_src</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">yes</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Unarchive a file that needs to be downloaded (added in 2.0)</span>
<span class="w">  </span><span class="nt">ansible.builtin.unarchive</span><span class="p">:</span>
<span class="w">    </span><span class="nt">src</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">https://example.com/example.zip</span>
<span class="w">    </span><span class="nt">dest</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/usr/local/bin</span>
<span class="w">    </span><span class="nt">remote_src</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">yes</span>

<span class="p p-Indicator">-</span><span class="w"> </span><span class="nt">name</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">Unarchive a file with extra options</span>
<span class="w">  </span><span class="nt">ansible.builtin.unarchive</span><span class="p">:</span>
<span class="w">    </span><span class="nt">src</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/tmp/foo.zip</span>
<span class="w">    </span><span class="nt">dest</span><span class="p">:</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">/usr/local/bin</span>
<span class="w">    </span><span class="nt">extra_opts</span><span class="p">:</span>
<span class="w">    </span><span class="p p-Indicator">-</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">--transform</span>
<span class="w">    </span><span class="p p-Indicator">-</span><span class="w"> </span><span class="l l-Scalar l-Scalar-Plain">s/^xxx/yyy/</span>
</pre><button class="copybtn o-tooltip--left" data-tooltip="Copy" data-clipboard-target="#codecell0">
      <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-copy" width="44" height="44" viewBox="0 0 24 24" stroke-width="1.5" stroke="#000000" fill="none" stroke-linecap="round" stroke-linejoin="round">
  <title>Copy to clipboard</title>
  <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
  <rect x="8" y="8" width="12" height="12" rx="2"></rect>
  <path d="M16 8v-2a2 2 0 0 0 -2 -2h-8a2 2 0 0 0 -2 2v8a2 2 0 0 0 2 2h2"></path>
</svg>
    </button></div>
</div>
</section>
<section id="return-values">
<h2><a class="toc-backref" href="#id7" role="doc-backlink">Return Values</a><a class="headerlink" href="#return-values" title="Permalink to this heading"></a></h2>
<p>Common return values are documented <a class="reference internal" href="../../../reference_appendices/common_return_values.html#common-return-values"><span class="std std-ref">here</span></a>, the following are the fields unique to this module:</p>
<div class="wy-table-responsive"><table class="longtable ansible-option-table docutils align-default" style="width: 100%">
<thead>
<tr class="row-odd"><th class="head"><p>Key</p></th>
<th class="head"><p>Description</p></th>
</tr>
</thead>
<tbody>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-dest"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-return-dest"><strong>dest</strong></p>
<a class="ansibleOptionLink" href="#return-dest" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Path to the destination directory.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> always</p>
<p class="ansible-option-line ansible-option-sample"><strong class="ansible-option-sample-bold">Sample:</strong> <code class="ansible-option-sample docutils literal notranslate"><span class="pre">"/opt/software"</span></code></p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-files"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-return-files"><strong>files</strong></p>
<a class="ansibleOptionLink" href="#return-files" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">list</span> / <span class="ansible-option-elements">elements=string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>List of all the files in the archive.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> When <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-list-files"><span class="std std-ref"><span class="pre">list_files</span></span></a></strong></code> is <code class="ansible-value docutils literal notranslate"><span class="pre">True</span></code></p>
<p class="ansible-option-line ansible-option-sample"><strong class="ansible-option-sample-bold">Sample:</strong> <code class="ansible-option-sample docutils literal notranslate"><span class="pre">["[\"file1\"",</span> <span class="pre">"</span> <span class="pre">\"file2\"]"]</span></code></p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-gid"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-return-gid"><strong>gid</strong></p>
<a class="ansibleOptionLink" href="#return-gid" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">integer</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Numerical ID of the group that owns the destination directory.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> always</p>
<p class="ansible-option-line ansible-option-sample"><strong class="ansible-option-sample-bold">Sample:</strong> <code class="ansible-option-sample docutils literal notranslate"><span class="pre">1000</span></code></p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-group"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-return-group"><strong>group</strong></p>
<a class="ansibleOptionLink" href="#return-group" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Name of the group that owns the destination directory.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> always</p>
<p class="ansible-option-line ansible-option-sample"><strong class="ansible-option-sample-bold">Sample:</strong> <code class="ansible-option-sample docutils literal notranslate"><span class="pre">"librarians"</span></code></p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-handler"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-return-handler"><strong>handler</strong></p>
<a class="ansibleOptionLink" href="#return-handler" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Archive software handler used to extract and decompress the archive.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> always</p>
<p class="ansible-option-line ansible-option-sample"><strong class="ansible-option-sample-bold">Sample:</strong> <code class="ansible-option-sample docutils literal notranslate"><span class="pre">"TgzArchive"</span></code></p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-mode"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-return-mode"><strong>mode</strong></p>
<a class="ansibleOptionLink" href="#return-mode" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>String that represents the octal permissions of the destination directory.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> always</p>
<p class="ansible-option-line ansible-option-sample"><strong class="ansible-option-sample-bold">Sample:</strong> <code class="ansible-option-sample docutils literal notranslate"><span class="pre">"0755"</span></code></p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-owner"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-return-owner"><strong>owner</strong></p>
<a class="ansibleOptionLink" href="#return-owner" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Name of the user that owns the destination directory.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> always</p>
<p class="ansible-option-line ansible-option-sample"><strong class="ansible-option-sample-bold">Sample:</strong> <code class="ansible-option-sample docutils literal notranslate"><span class="pre">"paul"</span></code></p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-size"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-return-size"><strong>size</strong></p>
<a class="ansibleOptionLink" href="#return-size" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">integer</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The size of destination directory in bytes. Does not include the size of files or subdirectories contained within.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> always</p>
<p class="ansible-option-line ansible-option-sample"><strong class="ansible-option-sample-bold">Sample:</strong> <code class="ansible-option-sample docutils literal notranslate"><span class="pre">36</span></code></p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-src"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-return-src"><strong>src</strong></p>
<a class="ansibleOptionLink" href="#return-src" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>The source archive’s path.</p>
<p>If <code class="ansible-option docutils literal notranslate"><strong><a class="reference internal" href="#ansible-collections-ansible-builtin-unarchive-module-parameter-src"><span class="std std-ref"><span class="pre">src</span></span></a></strong></code> was a remote web URL, or from the local ansible controller, this shows the temporary location where the download was stored.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> always</p>
<p class="ansible-option-line ansible-option-sample"><strong class="ansible-option-sample-bold">Sample:</strong> <code class="ansible-option-sample docutils literal notranslate"><span class="pre">"/home/paul/test.tar.gz"</span></code></p>
</div></td>
</tr>
<tr class="row-odd"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-state"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-return-state"><strong>state</strong></p>
<a class="ansibleOptionLink" href="#return-state" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">string</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>State of the destination. Effectively always “directory”.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> always</p>
<p class="ansible-option-line ansible-option-sample"><strong class="ansible-option-sample-bold">Sample:</strong> <code class="ansible-option-sample docutils literal notranslate"><span class="pre">"directory"</span></code></p>
</div></td>
</tr>
<tr class="row-even"><td><div class="ansible-option-cell">
<div class="ansibleOptionAnchor" id="return-uid"></div><p class="ansible-option-title" id="ansible-collections-ansible-builtin-unarchive-module-return-uid"><strong>uid</strong></p>
<a class="ansibleOptionLink" href="#return-uid" title="Permalink to this return value"></a><p class="ansible-option-type-line"><span class="ansible-option-type">integer</span></p>
</div></td>
<td><div class="ansible-option-cell"><p>Numerical ID of the user that owns the destination directory.</p>
<p class="ansible-option-line"><strong class="ansible-option-returned-bold">Returned:</strong> always</p>
<p class="ansible-option-line ansible-option-sample"><strong class="ansible-option-sample-bold">Sample:</strong> <code class="ansible-option-sample docutils literal notranslate"><span class="pre">1000</span></code></p>
</div></td>
</tr>
</tbody>
</table></div>
<section id="authors">
<h3>Authors<a class="headerlink" href="#authors" title="Permalink to this heading"></a></h3>
<ul class="simple">
<li><p>Michael DeHaan</p></li>
</ul>
</section>
<section id="collection-links">
<h3>Collection links<a class="headerlink" href="#collection-links" title="Permalink to this heading"></a></h3>
<ul class="ansible-links">
<li><span><a aria-role="button" class="ansible-link reference external" href="https://github.com/ansible/ansible/issues" rel="noopener external" target="_blank">Issue Tracker</a></span></li>
<li><span><a aria-role="button" class="ansible-link reference external" href="https://github.com/ansible/ansible" rel="noopener external" target="_blank">Repository (Sources)</a></span></li>
<li><span><a class="reference internal" href="index.html#communication-for-ansible-builtin"><span class="std std-ref">Communication</span></a></span></li>
</ul>
</section>
</section>
