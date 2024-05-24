# ACLs

<div class="clearfix field field--name-body field--type-text-with-summary field--label-hidden field__item"><p>Among the challenges of administering Linux in the modern business environment is the expectation that we can and should manage who has access to what information. Once upon a time, the only folks who needed access to Linux filesystems could be categorized in a general way: through Linux filesystem permissions.</p>

<h2 id="reviewing-the-basics">Reviewing the basics</h2>

<div data-embed-button="resource_list" data-entity-embed-display="view_mode:resource_list.link" data-entity-type="resource_list" data-entity-uuid="60b26066-acd0-4332-afa7-d98c9a079f02" data-langcode="en" class="align-right embedded-entity embedded-entity--resources embedded-entity--resources--link" data-entity-embed-display-settings="[]"><aside data-analytics-region="sidebar" id="resource-list-great-linux-resources" class="eck-entity mt-2 py-3 pr-3 border-top border-danger embedded-resource-list"><a href="#bottom-list" class="visually-hidden focusable skip-link">Skip to the bottom of list</a>
  

<h2 class="h4">
      Great Linux resources
  </h2>

<ul class="pl-3 mb-0"><li class="my-2"><a href="https://developers.redhat.com/cheat-sheets/advanced-linux-commands/?intcmp=701f20000012ngPAAQ" data-analytics-category="resource list" data-analytics-text="Advanced Linux commands cheat sheet">Advanced Linux commands cheat sheet</a></li>
      <li class="my-2"><a href="https://developers.redhat.com/products/rhel/download?intcmp=701f20000012ngPAAQ" data-analytics-category="resource list" data-analytics-text="Download RHEL 9 at no charge through the Red Hat Developer program">Download RHEL 9 at no charge through the Red Hat Developer program</a></li>
      <li class="my-2"><a href="https://opensource.com/downloads/installing-linux-applications-ebook?intcmp=701f20000012ngPAAQ" data-analytics-category="resource list" data-analytics-text="A guide to installing applications on Linux">A guide to installing applications on Linux</a></li>
      <li class="my-2"><a href="https://rhtapps.redhat.com/assessment/?intcmp=701f20000012ngPAAQ" data-analytics-category="resource list" data-analytics-text="Linux system administration skills assessment">Linux system administration skills assessment</a></li>
      <li class="my-2"><a href="https://redhatdg.co1.qualtrics.com/jfe/form/SV_bjRFSHqPdTpIjoa?intcmp=701f20000012ngPAAQ" data-analytics-category="resource list" data-analytics-text="How well do you know Linux? Take a quiz and get a badge">How well do you know Linux? Take a quiz and get a badge</a></li>
  </ul><a id="bottom-list" tabindex="-1"></a>
</aside></div>
<p>The Linux filesystem gives us three types of permissions. Here is a simplified review:</p>

<ul><li><strong>U</strong>ser (or user owner)</li>
	<li><strong>G</strong>roup (or owner group)</li>
	<li><strong>O</strong>ther (everyone else)</li>
</ul><p>With these permissions, we can grant three (actually five, but we’ll get to that in a minute) types of access:</p>

<ul><li><strong>R</strong>ead</li>
	<li><strong>W</strong>rite</li>
	<li>e<strong>X</strong>ecute</li>
</ul><p>These levels of access are often adequate in many cases. Say that you have a directory where files from the accounting department live. You might set these permissions to:</p>

<pre><code class="language-shell hljs css" style="overflow-x: auto;"><span class="hljs-tag">drwxrwxr-x</span>  2 <span class="hljs-tag">accounting</span> <span class="hljs-tag">accounting</span>  12 <span class="hljs-tag">Jan</span>  8 15<span class="hljs-pseudo">:13</span>
</code></pre>

<p>The accounting service user (the user owner) can read and write to the directory, and members of the <code>accounting</code> group (or owner group) can read and write. Others (users not in the accounting department) can, however, see and execute what’s in there, which some might think is a bad idea.</p>

<p><strong>[ Also popular:&nbsp;<a href="https://www.redhat.com/sysadmin/linux-user-account-management">Linux sysadmin basics: User account management</a> ]</strong></p>

<p>So, we might change the permissions to this:</p>

<pre><code class="language-shell hljs css" style="overflow-x: auto;"><span class="hljs-tag">drwxrwx---</span>  2 <span class="hljs-tag">accounting</span> <span class="hljs-tag">accounting</span>  12 <span class="hljs-tag">Jan</span>  8 15<span class="hljs-pseudo">:13</span> .
</code></pre>

<p><strong>Note:</strong> You can also use special permissions to control settings like who actually owns new files created in that directory, as well as the <strong>sticky bit</strong> which controls whether members of the group can delete each other's files. However, that's outside the scope of this discussion.</p>

<h2 id="viewing-the-current-acl">Viewing the current ACL</h2>

<p>What if you have an accounting intern (Kenny) who needs to be able to read certain files (or even just the files owned by Fred, his manager)? Or maybe people in the sales department also need access to the <code>accounting</code> owner’s files to create invoices for Fred’s team in order to bill customers, but you don’t want the sales team to see the other reports that Fred's team generates. This situation can be tricky because, with regular permissions, each file and directory can have only one user and group owner at a time. This type of situation is what Linux Access Control Lists (ACLs) were intended to resolve.</p>

<p>ACLs allow us to apply a more specific set of permissions to a file or directory without (necessarily) changing the base ownership and permissions. They let us "tack on"&nbsp;access for other users or groups.</p>

<p>We can view the current ACL using the <code>getfacl</code> command:</p>

<pre><code class="language-shell hljs ruby" style="overflow-x: auto;">[root]<span class="hljs-comment"># getfacl /accounting</span>
<span class="hljs-symbol">getfacl:</span> <span class="hljs-constant">Removing</span> leading <span class="hljs-string">'/'</span> from absolute path names
<span class="hljs-comment"># file: accounting</span>
<span class="hljs-comment"># owner: accounting</span>
<span class="hljs-comment"># group: accounting</span>
<span class="hljs-symbol">user:</span><span class="hljs-symbol">:rwx</span>
<span class="hljs-symbol">group:</span><span class="hljs-symbol">:rwx</span>
<span class="hljs-symbol">other:</span><span class="hljs-symbol">:---</span>
</code></pre>

<p>We can see that right now, there are no ACLs on this directory because the only permissions listed are for the user, group, and other. In this case, that's to be expected, because I just created this directory in the lab and haven't done anything other than assigning ownership. So, let's start by adding a default ACL:</p>

<h2 id="setting-an-acl">Setting an ACL</h2>

<p>The syntax for setting an ACL looks like this:</p>

<pre><code class="language-plaintext hljs css" style="overflow-x: auto;"><span class="hljs-tag">setfacl</span> <span class="hljs-attr_selector">[option]</span> <span class="hljs-attr_selector">[action/specification]</span> <span class="hljs-tag">file</span>
</code></pre>

<p>The 'action' would be <code>-m</code> (modify) or&nbsp;<code>-x</code> (remove), and the specification would be the user or group followed by the permissions we want to set. In this case, we would use the option <code>-d</code> (defaults). So, to set the default ACL for this directory, we would execute:</p>

<pre><code class="language-shell hljs bash" style="overflow-x: auto;">[root]<span class="hljs-comment"># setfacl -d -m accounting:rwx /accounting</span>
</code></pre>

<p>After which we can now see the default ACL info for that directory:</p>

<pre><code class="language-shell hljs cs" style="overflow-x: auto;">[root]<span class="hljs-preprocessor"># getfacl /accounting</span>
[root]<span class="hljs-preprocessor"># getfacl: Removing leading '/' from absolute path names</span>
<span class="hljs-preprocessor"># file: accounting</span>
<span class="hljs-preprocessor"># owner: accounting</span>
<span class="hljs-preprocessor"># group: accounting</span>
user::rwx
<span class="hljs-keyword">group</span>::rwx
other::---
<span class="hljs-keyword">default</span>:user::rwx
<span class="hljs-keyword">default</span>:user:accounting:rwx
<span class="hljs-keyword">default</span>:<span class="hljs-keyword">group</span>::rwx
<span class="hljs-keyword">default</span>:mask::rwx
<span class="hljs-keyword">default</span>:other::---
</code></pre>

<p>What if Fred creates a file in that directory?</p>

<pre><code class="language-shell hljs css" style="overflow-x: auto;"><span class="hljs-attr_selector">[fred]</span>$ <span class="hljs-tag">touch</span> <span class="hljs-tag">test</span>
<span class="hljs-attr_selector">[fred]</span>$ <span class="hljs-tag">ls</span> <span class="hljs-tag">-la</span>
<span class="hljs-tag">drwxrwx---</span>+  2 <span class="hljs-tag">accounting</span> <span class="hljs-tag">accounting</span>  18 <span class="hljs-tag">Jan</span>  8 17<span class="hljs-pseudo">:51</span> .
<span class="hljs-tag">dr-xr-xr-x</span>. 18 <span class="hljs-tag">root</span>  <span class="hljs-tag">root</span>  262 <span class="hljs-tag">Jan</span>  8 15<span class="hljs-pseudo">:13</span> ..
<span class="hljs-tag">-rw-rw----</span>+  1 <span class="hljs-tag">fred</span>  <span class="hljs-tag">accounting</span>  0 <span class="hljs-tag">Jan</span>  8 17<span class="hljs-pseudo">:51</span> <span class="hljs-tag">test</span>
<span class="hljs-attr_selector">[fred]</span>$ <span class="hljs-tag">getfacl</span> <span class="hljs-tag">test</span>
# <span class="hljs-tag">file</span>: <span class="hljs-tag">test</span>
# <span class="hljs-tag">owner</span>: <span class="hljs-tag">fred</span>
# <span class="hljs-tag">group</span>: <span class="hljs-tag">accounting</span>
<span class="hljs-tag">user</span><span class="hljs-pseudo">::rw-</span>
<span class="hljs-tag">user</span><span class="hljs-pseudo">:accounting</span><span class="hljs-pseudo">:rwx</span>  <span class="hljs-id">#effective</span><span class="hljs-pseudo">:rw-</span>
<span class="hljs-tag">group</span><span class="hljs-pseudo">::rwx</span>  <span class="hljs-id">#effective</span><span class="hljs-pseudo">:rw-</span>
</code></pre>

<p>What happens if Kenny tries to create a file? You may be able to guess that because&nbsp;<code>kenny</code> is not in the <code>accounting</code> group, he won’t have permission. But we want Kenny to have a good experience working with us, so we need to give him&nbsp;the ability to see what files are in the <code>accounting</code> directory, and we want him to be able to create new files:</p>

<pre><code class="language-shell hljs ruby" style="overflow-x: auto;">[root<span class="hljs-variable">@lab1</span> accounting]setfacl -m <span class="hljs-symbol">kenny:</span>rwx /accounting
[root]getfacl ./
<span class="hljs-comment"># file: .</span>
<span class="hljs-comment"># owner: accounting</span>
<span class="hljs-comment"># group: accounting</span>
<span class="hljs-symbol">user:</span><span class="hljs-symbol">:rwx</span>
<span class="hljs-symbol">user:</span><span class="hljs-symbol">kenny:</span>rwx
</code></pre>

<p>So far so good. But what if we don’t want this user to create files in the <code>accounting</code> directory? Instead, we only want to let him read the files there, and he can create new files in his own folder.</p>

<p><strong>[ Related article:&nbsp;<a href="https://www.redhat.com/sysadmin/user-account-gid-uid">Linux sysadmin basics: User account management with UIDs and GIDs</a> ]</strong></p>

<p>We can set Kenny’s access on the <code>accounting</code> folder like this:</p>

<pre><code class="language-shell hljs ruby" style="overflow-x: auto;">[root<span class="hljs-variable">@lab1</span> accounting]<span class="hljs-comment"># setfacl -m kenny:r-x /accounting</span>
[root]<span class="hljs-comment"># getfacl ./</span>
<span class="hljs-comment"># file: .</span>
<span class="hljs-comment"># owner: accounting</span>
<span class="hljs-comment"># group: accounting</span>
<span class="hljs-symbol">user:</span><span class="hljs-symbol">:rwx</span>
<span class="hljs-constant">User</span><span class="hljs-symbol">:kenny</span><span class="hljs-symbol">:r-x</span>
</code></pre>

<p>Now we make Kenny his own folder, give him ownership, and then make the <code>accounting</code> group the group owner so that other people in the <code>accounting</code> group can see what’s in there:</p>

<pre><code class="language-shell hljs ruby" style="overflow-x: auto;">[root<span class="hljs-variable">@lab1</span> accounting]<span class="hljs-comment"># mkdir ./kenny</span>
[root]<span class="hljs-comment"># chown kenny:accounting ./kenny</span>
[root]<span class="hljs-comment"># getfacl ./kenny</span>
<span class="hljs-comment"># file: kenny</span>
<span class="hljs-comment"># owner: kenny</span>
<span class="hljs-comment"># group: accounting</span>
<span class="hljs-symbol">user:</span><span class="hljs-symbol">:rwx</span>
<span class="hljs-symbol">user:</span><span class="hljs-symbol">accounting:</span>rwx
<span class="hljs-symbol">group:</span><span class="hljs-symbol">:rwx</span>
</code></pre>

<p>You've created a folder within the <code>accounting</code> group that's owned by the user <code>kenny</code>. He now is able to see the accounting folder, but only create files in his own folder:</p>

<pre><code class="language-shell hljs ruby" style="overflow-x: auto;">[root<span class="hljs-variable">@lab1</span> accounting]<span class="hljs-comment"># su kenny</span>
[kenny]<span class="hljs-variable">$ </span>touch test
<span class="hljs-symbol">touch:</span> cannot touch ‘test’<span class="hljs-symbol">:</span> <span class="hljs-constant">Permission</span> denied
[kenny]<span class="hljs-variable">$ </span>cd ./kenny
[kenny]<span class="hljs-variable">$ </span>touch test
[kenny]<span class="hljs-variable">$ </span>ls
test
</code></pre>

<p>Note that because the folder is owned by the <code>accounting</code> group, anyone in that group can put files there. Because we’re dealing with an intern, this factor is probably fine. However, what if we give Kenny a promotion to chief auditor and want to keep his work a secret from Fred?</p>

<pre><code class="language-shell hljs ruby" style="overflow-x: auto;">[root]<span class="hljs-comment"># setfacl -m fred:- ./kenny</span>
[root]<span class="hljs-comment"># getfacl ./kenny</span>
<span class="hljs-comment"># file: kenny</span>
<span class="hljs-comment"># owner: kenny</span>
<span class="hljs-comment"># group: accounting</span>
<span class="hljs-symbol">user:</span><span class="hljs-symbol">:rwx</span>
<span class="hljs-symbol">user:</span><span class="hljs-symbol">accounting:</span>---
<span class="hljs-symbol">user:</span><span class="hljs-symbol">fred:</span>---
</code></pre>

<p>What if we didn’t want <em>anyone</em> to see what Kenny is working on?</p>

<pre><code class="language-shell hljs bash" style="overflow-x: auto;">[root]<span class="hljs-comment"># setfacl -m g:accounting:- ./kenny</span>
</code></pre>

<p><strong>Note:</strong> When we want to set a <em>group</em> ACL, we need to specify this by putting <code>g:</code> in front of the group’s name. For users, just change the <code>g</code> to a <code>u</code>, but <code>setfacl</code> will assume we are talking about a user if you don’t put anything in that spot.</p>

<p>We still have to remove the base permissions for the group owner so that the rest of the accounting team can’t snoop into Kenny’s reports:</p>

<pre><code class="language-shell hljs ruby" style="overflow-x: auto;">[root]<span class="hljs-comment"># chmod g-rwx ./kenny</span>
[root]<span class="hljs-comment"># ls -al</span>
total <span class="hljs-number">0</span>
drwxrwx-wx+  <span class="hljs-number">3</span> accounting accounting  <span class="hljs-number">44</span> <span class="hljs-constant">Jan</span>  <span class="hljs-number">9</span> <span class="hljs-number">16</span><span class="hljs-symbol">:</span><span class="hljs-number">38</span> .
dr-xr-xr-x. <span class="hljs-number">18</span> root       root       <span class="hljs-number">262</span> <span class="hljs-constant">Jan</span>  <span class="hljs-number">8</span> <span class="hljs-number">15</span><span class="hljs-symbol">:</span><span class="hljs-number">13</span> ..
drwx------+  <span class="hljs-number">2</span> kenny      accounting  <span class="hljs-number">18</span> <span class="hljs-constant">Jan</span>  <span class="hljs-number">9</span> <span class="hljs-number">17</span><span class="hljs-symbol">:</span><span class="hljs-number">07</span> kenny
-rw-rw----+  <span class="hljs-number">1</span> root       root         <span class="hljs-number">0</span> <span class="hljs-constant">Jan</span>  <span class="hljs-number">9</span> <span class="hljs-number">16</span><span class="hljs-symbol">:</span><span class="hljs-number">33</span> test
-rw-rw----+  <span class="hljs-number">1</span> kenny      accounting   <span class="hljs-number">0</span> <span class="hljs-constant">Jan</span>  <span class="hljs-number">9</span> <span class="hljs-number">16</span><span class="hljs-symbol">:</span><span class="hljs-number">27</span> test2
[root]<span class="hljs-comment"># getfacl ./kenny</span>
<span class="hljs-comment"># file: kenny</span>
<span class="hljs-comment"># owner: kenny</span>
<span class="hljs-comment"># group: accounting</span>
<span class="hljs-symbol">user:</span><span class="hljs-symbol">:rwx</span>
<span class="hljs-symbol">user:</span><span class="hljs-symbol">accounting:</span>---
<span class="hljs-symbol">user:</span><span class="hljs-symbol">fred:</span>---
<span class="hljs-symbol">group:</span><span class="hljs-symbol">:rwx</span>  <span class="hljs-comment">#effective:---</span>
[root]<span class="hljs-comment"># su jan</span>
[jan]<span class="hljs-variable">$ </span>touch ./kenny/test
<span class="hljs-symbol">touch:</span> cannot touch ‘./kenny/test’<span class="hljs-symbol">:</span> <span class="hljs-constant">Permission</span> denied
</code></pre>

<p>Now we can manage who else can see or write to Kenny’s folder without changing the ownership. Let’s give the CEO (Lisa, who is not a member of the accounting team, and won’t have access to the rest of the folder) access to Kenny’s stuff:</p>

<pre><code class="language-shell hljs ruby" style="overflow-x: auto;">[root<span class="hljs-variable">@lab1</span> accounting]<span class="hljs-comment"># useradd lisa</span>
[root]<span class="hljs-comment"># setfacl -m u:lisa:rwx ./kenny</span>
[root]<span class="hljs-comment"># su lisa</span>
[lisa]<span class="hljs-variable">$ </span>touch ./kenny/lisa
[lisa]<span class="hljs-variable">$ </span>ls ./kenny
lisa  test
[lisa]<span class="hljs-variable">$ </span>touch test
<span class="hljs-symbol">touch:</span> cannot touch ‘test’<span class="hljs-symbol">:</span> <span class="hljs-constant">Permission</span> denied
[root]<span class="hljs-comment"># getfacl ./kenny</span>
<span class="hljs-comment"># file: kenny</span>
<span class="hljs-comment"># owner: kenny</span>
<span class="hljs-comment"># group: accounting</span>
<span class="hljs-symbol">user:</span><span class="hljs-symbol">:rwx</span>
<span class="hljs-symbol">user:</span><span class="hljs-symbol">accounting:</span>---
<span class="hljs-symbol">user:</span><span class="hljs-symbol">fred:</span>---
<span class="hljs-symbol">user:</span><span class="hljs-symbol">lisa:</span>rwx
<span class="hljs-symbol">group:</span><span class="hljs-symbol">:rwx</span>
<span class="hljs-symbol">group:</span><span class="hljs-symbol">accounting:</span>---
</code></pre>

<p>Note again that the group owner permissions remain wide open, but the accounting group (which is still the owner), no longer has access to that folder. So, who owns it?</p>

<pre><code class=" hljs css" style="overflow-x: auto;"><span class="hljs-tag">drwxrwx---</span>+  2 <span class="hljs-tag">kenny</span>  <span class="hljs-tag">accounting</span>  30 <span class="hljs-tag">Jan</span>  9 17<span class="hljs-pseudo">:16</span> <span class="hljs-tag">kenny</span>
</code></pre>

<p>This part is tricky. It’s useful to know that we can take away the owner’s permissions without changing ownership, but you might want to consider whether this is the result you want.</p>

<h2 id="wrapping-up">Conclusion</h2>

<p>So these are the basics. ACLs can be confusing, so I encourage you to give the man pages for <code>setfacl</code> and <code>getfacl</code> a good read. There are many more interesting and useful things you can do with these tools, but hopefully, you now understand enough to get you started.</p>

